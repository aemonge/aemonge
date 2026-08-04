# Known Bugs

## spi validation: Pi XDG config/data resources missing

- **Status:** Fixed in working tree
- **Observed:** `spi -- --validate` fails Test E.11 with `Pi XDG config/data resource policy failed`.
- **Reproduction snippet:**
  ```console
  spi -- --validate
  # Test E.11 FAIL: Pi XDG config/data resource policy failed
  ```
- **Current evidence:** The validation fixture/run did not provide the expected sandbox paths:
  - `${HOME}/.config/pi/config.toml`
  - `${HOME}/.local/share/pi/resource.txt`
- **Next investigation notes:** This is likely a Pi-specific XDG/resource mount or validation fixture issue. Check how `bind_pi_xdg_resources` maps host XDG config/data into the sandbox HOME during validation. Do not chase OpenCode `.opencode` paths for this failure.
- **Resolution:** `bind_pi_xdg_resources` now binds host Pi XDG config/data sources into canonical sandbox `$HOME/.config/pi` and `$HOME/.local/share/pi`, and validation now supplies deterministic XDG fixture roots.

## spi validation: Pi XDG state/cache dirs not writable

- **Status:** Fixed in working tree
- **Observed:** `spi -- --validate` fails Test E.12 with `Pi XDG state/cache dirs are writable without broad XDG exposure`.
- **Reproduction snippet:**
  ```console
  spi -- --validate
  # Test E.12 FAIL: Pi XDG state/cache dirs are writable without broad XDG exposure
  ```
- **Current evidence:** The validation fixture/run did not provide the expected writable sandbox path:
  - `${HOME}/.local/state/pi/status`
- **Next investigation notes:** Inspect Pi-specific XDG state/cache bind creation and the validation fixture's expected HOME-relative state path. This appears related to Pi status/resource mounts, not OpenCode path handling.
- **Resolution:** `bind_pi_xdg_resources` now binds host Pi XDG state/cache sources into canonical sandbox `$HOME/.local/state/pi` and `$HOME/.cache/pi`, with sandbox XDG env vars canonicalized to those HOME-relative roots.

## spi interactive footer misses plain pi segment

- **Status:** Fixed in working tree
- **Observed:** Interactive `spi` still misses the plain `pi` footer segment.
- **Follow-up observed:** After XDG and pnpm fixes, `spi` validates and launches but still misses the OpenSpec/task footer segment shown by raw `pi` in `~/galactica`: `󰈙 ◷ check-os TOML config ▱▱▱▱▱ 0/8  1.1`. Resuming the same session with `spi --session <token>` still lacks the segment while `pi --session <token>` shows it.
- **Reproduction snippet:**
  ```console
  pi
  # footer includes: 󰈙 ◷ check-os TOML config ▱▱▱▱▱ 0/8  1.1

  spi
  # footer shows folder/model/context but not the plain pi segment above
  ```
- **Next investigation notes:** Compare the Pi status/footer resources and writable state visible to plain `pi` versus `spi`. Start with Pi-specific statusline/state/resource mounts and socket/status inheritance. Do not broaden the investigation into OpenCode `.opencode` paths unless new evidence directly implicates them.
- **Resolution:** Current Pi uses legacy `~/.pi/agent`, not `$XDG_CONFIG_HOME/pi`, for active config/resources. SPI now preserves the legacy/current `~/.pi` model while also supporting future XDG Pi paths: existing `~/.pi` is visible, selected `~/.pi/agent` runtime/state paths and mutable root JSON files are writable, and known `~/.pi/agent` resource/config children (`extensions`, `packages`, `prompts`, `skills`, `themes`, `keybindings.json`) are overlaid read-only with symlink targets followed at their logical HOME paths. A follow-up fix also exposes only footer-needed OpenCode/OpenSpec XDG resources read-only: `${XDG_CONFIG_HOME}/opencode`, `${XDG_CONFIG_HOME}/openspec`, and `${XDG_CACHE_HOME}/opencode/packages` into the sandbox canonical XDG config/cache paths. OpenCode data/state/auth/session DB paths remain unbound.

## spi real Pi launch: pnpm global module path missing

- **Status:** Fixed in working tree
- **Observed:** After validation passed on the host, invoking real Pi through SPI failed with Node `MODULE_NOT_FOUND` for `/home/aemonge/.local/share/pnpm/global/v11/5a25-19fc3888d1d/node_modules/@earendil-works/pi-coding-agent/dist/cli.js` under Node.js v22.23.2.
- **Current evidence:** The installed `pi` command is a pnpm shim at `${HOME}/.local/share/pnpm/bin/pi` that executes a CLI under `../global/v11/...`; that package entry resolves through pnpm store symlinks. Binding only the shim file leaves the package/store path unavailable inside the sandbox.
- **Resolution:** `discover_pi_binary` now detects pnpm-installed Pi shims and mounts the pnpm home tree read-only, preserving the shim, global package tree, and store symlink targets without write access or broad home exposure.

## spi footer shows stale galactica path outside galactica

- **Status:** Fixed in working tree
- **Observed:** In `~/.config/nvim`, raw `pi` footer shows the correct project/path (`nvim`) and OpenSpec segment, while `spi` launches but footer/status shows `~/galactica/.config/nvim` and a different/default-looking footer UI.
- **Current evidence:** SPI's bind/chdir target logic preserves explicit nested non-symlink targets, but two generic HOME/config interactions broke raw-Pi parity:
  - its broad environment inheritance forwarded parent OpenCode control-plane variables such as `OPENCODE`, `OPENCODE_PID`, `OPENCODE_DISABLE_PROJECT_CONFIG`, `OPENCODE_CONFIG_CONTENT`, plus stale workspace prefixes such as `USER_PREFIX`; follow-up inspection also found live stale-capable environment names outside the original filter, including `NVIM_OPENCODE_PORT`, `TMUX_WORKSPACE_ROOT`, `GALACTICA_HOME`, `MYVIMRC`, and non-auth `OPENCODE_*` variables;
  - when the selected project lived under sandbox `$HOME/.config`, SPI appended the project parent `--dir $HOME/.config` after footer/XDG child binds such as `$HOME/.config/opencode` and `$HOME/.config/pi`, so bubblewrap could hide those sibling resource mounts and Pi started without plugin/config resources.
- **Context7 health-check note:** Pi surfaces extension loading failures through startup diagnostics and exits non-zero when runtime diagnostics include failed extension loads, with a hint to restart using `pi -ne`. Context7 did not surface a dedicated `doctor --plugins` command; SPI keeps this covered with parser/static/validation checks and manual Pi diagnostic output instead of inventing a broad health feature.
- **Resolution:** `inherit_safe_environment` now filters stale parent workspace/session control variables before launching Pi, including broad non-auth `OPENCODE*` control vars and Neovim/OpenCode bridge variables while preserving `OPENCODE_API_KEY` for provider auth. SPI now separates logical sandbox target paths from resolved host source paths: symlinked targets keep their `$HOME` logical destination/cwd while the bind source follows the symlink. Project parent `--dir` entries are emitted before extra HOME/XDG child binds, preserving `$HOME/.config/opencode`, `$HOME/.config/pi`, and other resource mounts for arbitrary `$HOME/.config/<project>` targets. Parser tests cover direct and symlinked `$HOME/.config` project targets, mount ordering, exact logical `--chdir`, resolved-source binds, and stale env absence.

## spi legacy Pi agent resource symlinks do not resolve

- **Status:** Fixed in working tree
- **Observed:** Raw `pi` loads config/resources from `~/.pi/agent`, where active resource paths may be symlinks into another project tree (for example `extensions`, `packages`, `keybindings.json`, prompts/skills/themes). SPI exposed `~/.pi` and a writable `~/.pi/agent` root but did not overlay known resource symlink targets at the logical HOME paths, so symlink targets outside the sandbox target could be broken or masked.
- **Current evidence:** The installed Pi build reports `CONFIG_DIR_NAME` as `.pi` and `getAgentDir()` defaults to `~/.pi/agent`; user evidence showed `~/.config/pi` absent and `~/.pi/agent` holding the active package/extension/keybinding/resource layout. `$XDG_CONFIG_HOME/pi` remains future/standard compatibility, but it is not the current Pi's primary config root.
- **Resolution:** Added `bind_pi_agent_resource_paths`: after the writable agent root/state overlays, SPI read-only overlays known resource/config children (`extensions`, `packages`, `prompts`, `skills`, `themes`, `keybindings.json`) and follows symlink targets generically. Mutable root JSON files (`settings.json`, `trust.json`, `auth.json`, `models-store.json`) are overlaid writable when present so symlinked current-Pi config/auth/model stores resolve without hardcoding their targets. Parser tests use arbitrary fixture symlink targets, not galactica, and still retain future `$XDG_CONFIG_HOME/pi` coverage.
- **Follow-up observed:** Host retest failed before Pi startup with `bwrap: Can't bind mount /oldroot/.../.pi/agent/extensions on /newroot/$HOME/.pi/agent/extensions: Unable to mount source on destination: No such file or directory`. The source target was resolved correctly, but the sandbox destination leaf was inherited as a symlink/nonexistent path from the writable `~/.pi/agent` bind.
- **Follow-up resolution:** Normal mode now mounts `~/.pi` read-only, then creates `~/.pi/agent` as a writable tmpfs root instead of bind-mounting the host agent directory wholesale. Each known state/resource child is overlaid with a type-correct destination placeholder immediately before the bind (`--dir` for directories, empty `--file` for files), then the resolved symlink source is mounted back at the logical `$HOME/.pi/agent/<name>` path. This preserves generic symlink following without exposing or depending on galactica paths as project roots.
- **Second follow-up observed:** Host retest then failed on file placeholders with `bwrap: Can't write data to file $HOME/.pi/agent/settings.json: Bad file descriptor`.
- **Second follow-up evidence:** Opening the placeholder through Bash brace FD allocation (`exec {BWRAP_EMPTY_FILE_FD}<>...`) still produced the same host failure, so the FD used in the bwrap argv was not reliably inherited/usable by the bwrap process.
- **Second follow-up evidence:** Switching to a fixed inherited descriptor (`--file 9`) still produced the same host `Bad file descriptor`, so the FD-based `--file FD DEST` placeholder strategy is not reliable on the user's host.
- **Second follow-up resolution:** SPI no longer uses bwrap `--file` placeholders at all. For legacy Pi agent resources, the sandbox creates a tmpfs `~/.pi/agent`, prepares directory leaves with `--dir` only when the source is a directory, and directly overlays resolved file sources at the logical `$HOME/.pi/agent/<file>` paths after the tmpfs root exists. Parser/static tests now reject any `--file` usage.
- **Third follow-up observed:** Once live bwrap worked, `spi` reached Pi startup but Pi attempted `git clone https://github.com/hasit/pi-community-themes $HOME/.pi/agent/git/github.com/hasit/pi-community-themes`; `scoder-git` correctly denied the unknown `git clone` command. Raw Pi did not need to clone because the checkout already exists under host `~/.pi/agent/git`.
- **Third follow-up resolution:** No scoder-git policy change was made. SPI now treats Pi package-manager caches `~/.pi/agent/git` and `~/.pi/agent/npm` as writable agent state overlays, preserving existing git/npm package installs inside the tmpfs agent root so Pi does not reinstall/clone merely because SPI hid the caches.
- **Fourth follow-up observed:** From `~/galactica/.config/nvim`, raw `openspec list --json` resolves the nearest OpenSpec root at `~/galactica/.config/openspec` and reports `evaluate-pi-primary-harness` at `0/17`, while SPI initially exposed only the nested `nvim` target and made `openspec list --json` fall back to an empty implicit root inside `nvim`.
- **Fourth follow-up resolution:** SPI now discovers the nearest project-local `openspec/` directory by walking upward from the logical target path and exposes only that directory read-only when it lives outside the primary target bind. This preserves Pi footer OpenSpec/task parity for nested targets without broadening parent directory access.
- **Fifth follow-up observed:** The fourth fix covered the resolved path (`~/galactica/.config/nvim`) but not the logical symlink path (`~/.config/nvim`). In the logical path case, host `~/.config/openspec` exists and contains project markers, but its `changes/` child is a symlink to `~/galactica/.config/openspec/changes`. SPI mounted the wrapper directory read-only, leaving the internal `changes/` symlink dangling in the sandbox, so `openspec list --json` still returned an empty implicit root from `~/.config/nvim`.
- **Fifth follow-up resolution:** SPI now treats `openspec/changes` and `openspec/specs` as project-root markers, ignores non-project OpenSpec config dirs during footer discovery, and resolves symlinked marker children back to their owning OpenSpec root before mounting. For `~/.config/nvim`, it mounts the resolved project OpenSpec tree read-only at the logical `$HOME/.config/openspec` path, preserving logical cwd while following the safe project resource symlink without broad parent exposure.
- **Sixth follow-up observed:** After the fifth fix, `cd ~/.config/nvim; spi` showed the OpenSpec segment but still missed the ` 2` team/presence count. Presence records proved the widget keys sessions by `ctx.cwd`/workspace key: resolved Pi/SPI sessions used `/home/aemonge/galactica/.config/nvim`, while logical SPI used `/home/aemonge/.config/nvim`, so it did not count the existing resolved-path session. Separately, direct project `/tmp/a` had readable `openspec list --json` inside raw SPI probes, but the TUI footer omitted OpenSpec because the OpenSpec CLI emitted a telemetry note on stdout before JSON; `openspec-footer.ts` parses `stdout` directly with `JSON.parse`, catches the parse failure, and silently publishes no OpenSpec widgets.
- **Sixth follow-up resolution:** For symlinked directory targets, SPI now uses the resolved source path as the sandbox workdir (matching raw Node/Pi `process.cwd()` behavior), while still mounting the logical `$HOME/.config/...` alias and applying protection overlays to both resolved and logical destinations. SPI also sets `OPENSPEC_TELEMETRY=0` inside the sandbox so `pi.exec("openspec", ["list", "--json"])` returns clean JSON for footer parsing. Regression coverage now includes resolved nested targets, logical symlink targets with resolved OpenSpec at logical and resolved paths, and direct local OpenSpec targets with clean JSON output.

## spi notifications missing under SPI

- **Status:** Unresolved / TODO
- **Observed:** Notifications work or were observed outside SPI/raw Pi, but appear blocked or missing when running under `spi`.
- **Current evidence:** This has not been diagnosed or fixed. Footer parity commit `9f888ab` did not address notification delivery.
- **Next investigation notes:** Compare raw `pi` versus `spi` notification behavior directly. Likely investigation surfaces include DBus, `XDG_RUNTIME_DIR`, terminal OSC/socket notification mechanisms, and sandbox-visible runtime sockets, but these are hypotheses, not conclusions. Preserve SPI's intended no-upward-write boundary while testing any parity fix.
