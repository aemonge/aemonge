# scoder-git AI Denial Hints Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Add structured AI-assistant-only hints to every `scoder-git` denial path so blocked commands steer agents toward safe next actions.

**Architecture:** Keep `scoder-git` as the single policy boundary. Extend denial helpers to emit category-specific `hint: Assistant:` lines on both stdout and stderr, then route validators through small category wrappers rather than ad-hoc raw messages.

**Tech Stack:** Bash shell script, focused shell test harness in `test/scoder-git-test`.

## Global Constraints

- Use TDD: add failing tests before production changes.
- Preserve existing exit codes: generic policy denials exit `126`; fatal blocked outside-scoder commands exit `128`.
- Denial messages must remain visible on both stdout and stderr.
- Hints are for AI assistants only and should not instruct bypasses.
- Do not weaken existing command restrictions.

---

### Task 1: Add representative denial hint tests

**Files:**
- Modify: `/home/aemonge/usr/bin/test/scoder-git-test`

**Interfaces:**
- Consumes: existing `run_scoder_git`, `assert_denied`, `assert_denied_stdout_visible` helpers.
- Produces: focused assertions that fail until denial output includes `hint: Assistant:` guidance.

- [ ] **Step 1: Add hint assertion helper**

Add this helper after `assert_denied_stdout_visible`:

```bash
assert_denied_with_hint() {
    local tmpdir="$1"
    local name="$2"
    local expected_hint="$3"
    shift 3

    local output=""
    if output="$(run_scoder_git "${tmpdir}" "$@" 2>&1)"; then
        fail "${name}: command unexpectedly succeeded"
        return
    fi

    if [[ "${output}" == *"hint: Assistant:"* && "${output}" == *"${expected_hint}"* ]]; then
        pass "${name}"
    else
        fail "${name}: missing assistant hint '${expected_hint}', got: ${output}"
    fi
}
```

- [ ] **Step 2: Add representative failing tests**

Add these tests near the existing denied cases:

```bash
assert_denied_with_hint "${tmpdir}" "push denial has assistant hint" "never push from scoder" push
assert_denied_with_hint "${tmpdir}" "rebase denial has assistant hint" "do not rewrite or integrate history inside scoder" rebase main
assert_denied_with_hint "${tmpdir}" "clean denial has assistant hint" "do not delete untracked files" clean -fd
assert_denied_with_hint "${tmpdir}" "hard reset denial has assistant hint" "do not discard tracked work" reset --hard
assert_denied_with_hint "${tmpdir}" "unsafe switch denial has assistant hint" "use allowed branch-only switch forms" switch --force safe-target
assert_denied_with_hint "${tmpdir}" "unsafe config denial has assistant hint" "do not bypass scoder protections" -c core.hooksPath=.githooks commit -m unsafe
assert_denied_with_hint "${tmpdir}" "path escape denial has assistant hint" "keep paths inside the repository" commit -F /tmp/scoder-outside-message
assert_denied_with_hint "${tmpdir}" "unknown command denial has assistant hint" "ask the user whether this command should be added with tests" daemon
```

- [ ] **Step 3: Run RED verification**

Run:

```bash
bash -n /home/aemonge/usr/bin/test/scoder-git-test && /home/aemonge/usr/bin/test/scoder-git-test
```

Expected: new hint tests fail because current denial output has no `hint: Assistant:` lines.

---

### Task 2: Implement structured denial helpers and category hints

**Files:**
- Modify: `/home/aemonge/usr/bin/scoder-git`
- Modify: `/home/aemonge/usr/bin/test/scoder-git-test`

**Interfaces:**
- Consumes: existing `deny`, `deny_run_outside_scoder`, validators, and dispatch case.
- Produces: `emit_denial_lines`, `deny_with_hints`, category helpers, and all denial paths emitting at least one `hint: Assistant:` line.

- [ ] **Step 1: Replace denial helpers**

Update helpers near the top of `scoder-git` to centralize stdout/stderr emission and accept hints:

```bash
emit_denial_lines() {
    local -a lines=("$@")
    printf '%s\n' "${lines[@]}" >&2
    printf '%s\n' "${lines[@]}"
}

deny_with_hints() {
    local message="$1"
    shift

    local -a lines=("${PROGRAM_NAME}: Denied ${message}")
    local hint
    for hint in "$@"; do
        lines+=("hint: ${hint}")
    done
    emit_denial_lines "${lines[@]}"
    exit 126
}

deny() {
    deny_with_hints "$1" \
        "Assistant: stop and explain the blocked scoder-git policy to the user." \
        "Assistant: do not invent a bypass; ask whether the workflow or allowlist should change."
}
```

- [ ] **Step 2: Add category wrappers**

Add focused helpers below `deny`:

```bash
deny_network() { deny_run_outside_scoder "git $1" "network"; }
deny_history() { deny_run_outside_scoder "git $1" "history"; }
deny_destructive() { deny_with_hints "$1" "Assistant: do not delete untracked files or discard work from scoder." "Assistant: inspect status/diff and ask the user before any destructive cleanup."; }
deny_config_escape() { deny_with_hints "$1" "Assistant: do not bypass scoder protections with config, hooks, signing, or editor overrides." "Assistant: use only allowed identity config or ask the user to adjust scoder policy with tests."; }
deny_path_escape() { deny_with_hints "$1" "Assistant: keep paths inside the repository mounted for this scoder session." "Assistant: ask the user before staging or reading commit-message files outside the repo."; }
deny_unknown_command() { deny_with_hints "$1" "Assistant: scoder-git uses an allowlist; do not invent shell workarounds." "Assistant: ask the user whether this command should be added with tests."; }
```

- [ ] **Step 3: Update fatal blocked helper**

Replace `deny_run_outside_scoder` with a category-aware implementation:

```bash
deny_run_outside_scoder() {
    local command_text="$1"
    local category="${2:-generic}"
    local -a lines=(
        "fatal: scoder blocked ${command_text}; no ${command_text#git } was performed"
    )

    case "${category}" in
    network)
        lines+=(
            "hint: Assistant: never push from scoder or perform network Git operations from this sandbox."
            "hint: Assistant: summarize the intended remote operation and ask the user to run it outside scoder."
        )
        ;;
    history)
        lines+=(
            "hint: Assistant: do not rewrite or integrate history inside scoder."
            "hint: Assistant: explain the need and ask the user to run the history operation outside scoder."
        )
        ;;
    destructive)
        lines+=(
            "hint: Assistant: do not delete untracked files or discard work from scoder."
            "hint: Assistant: inspect status/diff and ask the user before any destructive cleanup."
        )
        ;;
    *)
        lines+=(
            "hint: Assistant: stop and explain the blocked scoder-git policy to the user."
            "hint: Assistant: do not invent a bypass; ask whether the workflow or allowlist should change."
        )
        ;;
    esac

    emit_denial_lines "${lines[@]}"
    exit 128
}
```

- [ ] **Step 4: Route call sites through categories**

Update call sites so all denials get better hints:

```bash
# Unsafe global config overrides
deny_config_escape "git global config override blocked: $2"

# Path escapes
deny_path_escape "git add path outside repo: ${arg}"
deny_path_escape "git commit message file outside repo: ${message_file}"

# Reset hard/destructive forms
deny_destructive "git reset --hard blocked except worktree internal shape"

# Dispatch
push | pull | fetch) deny_run_outside_scoder "git ${subcommand}" "network" ;;
rebase | merge | cherry-pick | revert | tag | checkout) deny_run_outside_scoder "git ${subcommand}" "history" ;;
clean) deny_run_outside_scoder "git ${subcommand}" "destructive" ;;
*) deny_unknown_command "unknown git command: git ${subcommand}" ;;
```

- [ ] **Step 5: Run GREEN verification**

Run:

```bash
bash -n /home/aemonge/usr/bin/scoder-git && bash -n /home/aemonge/usr/bin/test/scoder-git-test && /home/aemonge/usr/bin/test/scoder-git-test
```

Expected: all focused tests pass, existing denial visibility checks still pass.

---

## Self-Review

- Spec coverage: plan covers structured `fatal`/`hint: Assistant:` output, AI-only hints, representative denial categories, and both stdout/stderr visibility.
- Placeholder scan: no TBD/TODO placeholders remain.
- Type/signature consistency: helper names used in tests and implementation steps are defined in this plan.
