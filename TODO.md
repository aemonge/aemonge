# TODO: `spi` — Safe Pi

Build a safe launcher for Pi with **two isolation backends**:

1. **Bubblewrap backend** — run the entire Pi process inside a Linux `bwrap` sandbox, learning from `bin/scoder`.
2. **Gondolin backend** — keep Pi on the host and route its tools into a Gondolin micro-VM, learning from <https://github.com/pasky/pi-gondolin> and Pi's installed containerization guidance.

> Terminology: “Pi Bubblewrap” below means a Bubblewrap sandbox for the Pi coding agent, not a Python wrapper.

## Goals

- Provide a single `spi` command with predictable safety policies across both backends.
- Preserve Pi's normal interactive, print, JSON, RPC, session, model, skill, prompt, theme, and extension workflows where the selected backend can safely support them.
- Default to fail-closed behavior: inability to establish isolation must stop startup rather than silently run a tool on the host.
- Reuse proven `scoder` behavior without creating an unmaintainable copy of its entire script.
- Clearly communicate backend-specific trust boundaries; Bubblewrap and Gondolin do not isolate the same things.

## Non-goals for the first release

- Cross-platform Bubblewrap support; Bubblewrap is Linux-only.
- Claiming that Pi project trust is a sandbox.
- Treating Pi extensions as safe merely because project trust approved them.
- Transparently sandboxing arbitrary third-party extension tools in Gondolin unless they explicitly use the sandbox execution API.
- Perfectly identical guest environments between Bubblewrap and Gondolin.

## Threat model and security boundaries

- Protect host files outside explicitly mounted paths from model-issued commands and file operations.
- Protect repository control-plane files from accidental or model-directed mutation by default.
- Prevent sandbox startup failures from degrading into unsandboxed execution.
- Avoid exposing provider credentials, SSH credentials, host environment secrets, Pi authentication files, or host sockets to a Gondolin guest unless explicitly enabled.
- Document that the Bubblewrap backend runs Pi itself in the sandbox, so credentials required by Pi are necessarily available to the sandboxed Pi process.
- Document that trusted Pi extensions execute alongside the Pi process:
  - under Bubblewrap, extensions are inside Bubblewrap;
  - under Gondolin, extensions execute on the host unless their operations are routed into the VM.
- Network policy must be explicit per backend. Provider access must not imply unrestricted guest/tool network access without documentation.

## Common CLI and behavior

- [ ] Add `bin/spi` with usage similar to:

  ```text
  spi [PI_ARGS...] [-- [TARGET] [SPI_OPTIONS...]]
  spi [PI_ARGS...] -- [TARGET] -x COMMAND [ARG...]
  ```

- [ ] Support at least:
  - [ ] `--backend bwrap|gondolin|auto`
  - [ ] `--ro` and `--rw`
  - [ ] `-a, --add PATH` for an additional read-only path
  - [ ] `-A, --add-rw PATH` for an additional writable path
  - [ ] `--allow-git`
  - [ ] `--allow-infra`
  - [ ] `--allow-pi-config` for intentional Pi package/configuration maintenance
  - [ ] `--allow-host-tools` and `--no-host-tools` where meaningful
  - [ ] `--allow-network` and `--no-network` where supported
  - [ ] `--allow-gui`
  - [ ] `--no-ssh-agent`
  - [ ] `--no-nvim-remote`
  - [ ] `-x, --exec COMMAND...` for backend diagnostics
  - [ ] `--doctor`
  - [ ] `--validate`
  - [ ] `--quiet`, `--help`, and `--version`
- [ ] Forward every argument before `--` to Pi unchanged.
- [ ] Default `TARGET` to `$PWD`; canonicalize and validate it before launch.
- [ ] Support directory targets and, if retained from `scoder`, safe single-file targets.
- [ ] Preserve terminal resize, signals, exit status, cancellation, and streamed command output.
- [ ] Print the selected backend and effective high-level policy unless `--quiet` is used.
- [ ] Never silently fall back to plain `pi` or host tool execution.

## Shared filesystem policy

- [ ] Default project workspace to read-write, with an explicit `--ro` mode.
- [ ] Protect these repository paths read-only by default when present:
  - [ ] `.git/`
  - [ ] `.github/`
  - [ ] `.pi/`
  - [ ] `.agents/`
  - [ ] `.cargo/`
  - [ ] `.turbo/`
  - [ ] `AGENTS.md` and `CLAUDE.md`
  - [ ] `.gitignore`
  - [ ] common dependency lockfiles
- [ ] Define `--allow-git`, `--allow-infra`, and `--allow-pi-config` narrowly rather than making the entire host home writable.
- [ ] Keep extra read-only and read-write mounts explicit and visible in startup diagnostics.
- [ ] Reject nonexistent mounts and path escapes.
- [ ] Test symlinks that point outside the workspace; they must not bypass the selected filesystem policy.

## Shared Git policy

- [ ] Create or generalize a policy-enforcing Git wrapper (`spi-git` or a shared safe-agent Git wrapper).
- [ ] Permit read-only inspection and explicitly allowlisted local operations.
- [ ] Block destructive cleanup, unsafe history rewriting, remote network operations, hooks/config bypasses, and paths outside the repository by default.
- [ ] Keep denial messages actionable for both the user and the coding agent.
- [ ] Add tests for every allowlisted and denied Git command shape.

## Bubblewrap backend requirements

- [ ] Extract/reuse a shared sandbox core from `bin/scoder` where practical; avoid an unchecked full copy.
- [ ] Run the **whole Pi process**, including trusted extensions, inside Bubblewrap.
- [ ] Mount `/usr`, runtime libraries, and required system configuration read-only.
- [ ] Use a tmpfs home shell with only explicit persistent paths mounted from the host.
- [ ] Use a private `/tmp` and restricted `/dev` by default.
- [ ] Preserve DNS/provider connectivity only according to the effective network policy.
- [ ] Discover the Pi executable safely, including the current `/usr/bin/pi -> /usr/lib/pi/pi` installation layout.
- [ ] Handle Pi state under `${PI_CODING_AGENT_DIR:-$HOME/.pi/agent}`:
  - [ ] sessions remain persistent and writable;
  - [ ] OAuth/API authentication can refresh without exposing unrelated home files;
  - [ ] trust and model metadata persist as required;
  - [ ] settings, extensions, skills, prompts, themes, npm packages, and git packages are read-only during normal sessions;
  - [ ] `--allow-pi-config` enables the minimum writes needed by `pi install`, `remove`, `update`, and `config`;
  - [ ] symlinked resources are resolved and mounted correctly (the current local Pi resources include symlinks into `~/galactica`).
- [ ] Support `~/.agents/skills` without exposing all of `~/.agents` as writable unless required.
- [ ] Forward only an audited environment set plus required provider configuration.
- [ ] Make SSH-agent, Neovim socket, GUI/session, and host-tool mounts explicit policy decisions.
- [ ] Set `PI_CODING_AGENT_DIR`, session paths, `HOME`, `PATH`, editor variables, and toolchain homes consistently inside the sandbox.
- [ ] Ensure Pi subprocesses receive valid `PI_SESSION_*`, `PI_PROVIDER`, `PI_MODEL`, and `PI_REASONING_LEVEL` values.

## Gondolin backend requirements

- [ ] Implement as a maintained Pi extension/package compatible with the installed Pi version and current `@earendil-works/*` APIs; do not blindly retain the older `@mariozechner/pi-coding-agent` imports from `pasky/pi-gondolin`.
- [ ] Depend on a reviewed/pinned compatible version of `@earendil-works/gondolin`.
- [ ] Check QEMU, Node.js, architecture support, guest image availability, and cache permissions in `--doctor`.
- [ ] Mount only the selected target at `/workspace` by default.
- [ ] Route **all enabled built-in filesystem and shell tools** into the VM:
  - [ ] `read`
  - [ ] `write`
  - [ ] `edit`
  - [ ] `bash`
  - [ ] `grep`
  - [ ] `find`
  - [ ] `ls`
- [ ] Route user-entered `!` and `!!` commands into the VM.
- [ ] If the VM is unavailable or still starting, queue/fail the operation; never use the host implementation as fallback.
- [ ] Enforce path containment for relative paths, absolute paths, `..`, symlinks, and tool working directories.
- [ ] Preserve binary reads, image MIME detection, large-file behavior, edit semantics, command timeouts, aborts, streaming output, and exit codes.
- [ ] Use an environment allowlist for guest commands. In particular, do not copy the complete Pi/host environment into `vm.exec()`.
- [ ] Keep Pi auth files and provider/API credentials outside the guest.
- [ ] Define guest network behavior and provide an explicit way to disable or enable it.
- [ ] Show VM startup/download progress and the host-to-guest mount mapping.
- [ ] Start eagerly enough to report setup errors, while retaining safe lazy initialization for tool calls.
- [ ] Close the VM reliably on normal exit, abort, startup failure, and signals.
- [ ] State clearly that arbitrary custom extension tools still run on the host unless routed or disabled.
- [ ] Consider a strict mode that disables unverified custom tools/extensions while using this backend.

## Pi integration requirements

- [ ] Preserve Pi project-trust prompts and `--approve`/`--no-approve`; document that trust is separate from sandboxing.
- [ ] Support interactive, `--print`, `--mode json`, and `--mode rpc`, or explicitly reject unsupported combinations before startup.
- [ ] Preserve session creation/resume/fork/export behavior.
- [ ] Preserve model authentication and model switching.
- [ ] Preserve global skills/prompts/themes and project resources according to Pi trust plus sandbox policy.
- [ ] Verify `/reload` cannot turn a protected project resource into a persistence or host-execution bypass.
- [ ] Audit package install/update behavior and prevent lifecycle scripts from escaping the chosen backend.
- [ ] Include backend identity in `SPI_BACKEND` for diagnostics without overwriting Pi's own session metadata.

## Packaging and documentation

- [ ] Document dependencies and installation for Linux Bubblewrap and Gondolin/QEMU.
- [ ] Document first-run Gondolin guest image download size and cache location.
- [ ] Document backend selection guidance:
  - [ ] Bubblewrap for whole-process Linux containment and trusted extensions inside the boundary.
  - [ ] Gondolin for keeping Pi/auth on the host while isolating built-in tools in a micro-VM.
- [ ] Document credential, network, extension, workspace-write-through, and custom-tool limitations.
- [ ] Add shell completions or completion-friendly `--help` output.
- [ ] Add versioning and a changelog entry.
- [ ] Keep `scoder` backward-compatible while shared components are extracted.

## Validation and test requirements

- [ ] Add fast unit tests for argument parsing, path normalization, environment filtering, and policy construction.
- [ ] Add integration tests for both backends, with capability-based skips when Bubblewrap/QEMU is unavailable.
- [ ] Verify the agent can read/write inside an allowed workspace in `--rw` mode.
- [ ] Verify `--ro` prevents all workspace writes.
- [ ] Verify host files outside mounts cannot be read or modified through each built-in tool or shell command.
- [ ] Verify protected infrastructure cannot be modified without its explicit override.
- [ ] Verify allowed extra mounts work and all other neighboring paths remain hidden.
- [ ] Verify symlink and `..` path escapes fail.
- [ ] Verify Git policy allow/deny cases.
- [ ] Verify Pi sessions persist and can be resumed.
- [ ] Verify Bubblewrap Pi resources follow legitimate host symlinks without exposing parent directories.
- [ ] Verify Gondolin guest commands cannot read Pi auth or provider credentials from files or environment.
- [ ] Verify Gondolin never falls back to host tools during startup or failure.
- [ ] Verify all seven current Pi built-in tools are either sandbox-routed or disabled.
- [ ] Verify `!` and `!!` commands are sandboxed.
- [ ] Verify cancellation, timeout, terminal resize, VM shutdown, and parent death cleanup.
- [ ] Verify unsupported backend/platform combinations fail with actionable messages.
- [ ] Run ShellCheck on shell components and TypeScript type-check/lint/tests on the Gondolin extension.
- [ ] Record startup-time baselines for both backends to catch severe regressions.

## Acceptance criteria

The initial `spi` release is accepted when all of the following are true:

1. `spi --backend bwrap` launches the installed Pi successfully on supported Linux systems without exposing the host home beyond documented mounts.
2. `spi --backend gondolin` launches Pi on the host while all enabled built-in tools and user shell commands execute only in the Gondolin VM.
3. A sandbox or VM initialization failure terminates the operation and cannot execute the requested command on the host.
4. Normal workspace edits are reflected on the host in `--rw` mode, while `--ro` blocks them.
5. Files outside explicitly mounted paths cannot be read or modified in automated escape tests.
6. Repository and Pi control-plane paths are read-only by default and require explicit, documented overrides.
7. Pi sessions and required authentication refresh behavior work without making the entire Pi configuration tree writable during normal coding sessions.
8. The Gondolin guest receives neither Pi auth files nor provider/host secret environment variables by default.
9. Git network, destructive, path-escape, and policy-bypass operations are denied by default in both backends.
10. Pi interactive, print, JSON, and RPC modes either pass integration tests or fail early with a documented unsupported-mode error.
11. `spi --doctor` reports all required dependencies, selected backend, mounts, credential exposure class, network policy, and actionable remediation.
12. `spi --validate` runs the backend's security integration suite and returns nonzero on any failed invariant.
13. Existing `scoder` behavior and its validation suite continue to pass after shared-code extraction.
14. Documentation accurately distinguishes Pi project trust, Bubblewrap whole-process containment, and Gondolin tool-only containment.

## Suggested delivery phases

### Phase 1 — specification and shared policy

- [ ] Finalize threat model and CLI.
- [ ] Inventory reusable `scoder` functions and tests.
- [ ] Define a backend-neutral policy/mount representation.

### Phase 2 — Bubblewrap MVP

- [ ] Implement `spi --backend bwrap`.
- [ ] Port relevant `scoder` validation tests.
- [ ] Add Pi state/resource persistence and protection tests.

### Phase 3 — Gondolin MVP

- [ ] Vendor, fork, or reimplement the reviewed `pi-gondolin` extension.
- [ ] Update it for current Pi APIs and all built-in tools.
- [ ] Remove host fallbacks and secret-environment propagation.

### Phase 4 — parity and hardening

- [ ] Unify CLI/diagnostics across backends.
- [ ] Complete escape, lifecycle, Git, and credential tests.
- [ ] Benchmark startup and document remaining backend differences.
