# scoder Safe Git Branch Switching Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Make `scoder-git` allow safe local `git switch` branch operations by default while preserving blocks for destructive, networked, and history-rewriting Git commands.

**Architecture:** Keep `/home/aemonge/usr/bin/scoder-git` as the single Git policy boundary. Replace blanket denial for `git switch` with a dedicated argument validator that allows only branch-navigation forms and rejects destructive or ambiguous flags. Add scoder validation coverage in `/home/aemonge/usr/bin/scoder` so allowed and denied behavior is checked inside the sandbox.

**Tech Stack:** Bash scripts, Git CLI, bubblewrap sandbox via `scoder`, existing `scoder --validate` test harness.

## Global Constraints

- Safe local branch switching is allowed by default.
- `git reset` remains denied unless a later reproduction identifies a safe minimal reset shape.
- `git push`, `git pull`, `git rebase`, `git merge`, `git clean`, `git reset --hard`, and other destructive/history/network operations remain blocked.
- Do not weaken existing `git add` path validation or guarded `git commit` behavior.
- `/home/aemonge/usr/bin` is not a Git repository in the current environment; skip commit steps unless this work is moved into a Git checkout.

---

## File Structure

- Modify: `/home/aemonge/usr/bin/scoder-git` — owns Git subcommand policy and will gain a `validate_switch_args` function.
- Modify: `/home/aemonge/usr/bin/scoder` — owns `--validate` integration tests and will gain allowed/denied `git switch` tests after existing Test M.3.
- Optional later modify: `/home/aemonge/usr/bin/scoder-git` — add `checkout` or constrained `reset` validators only if reproduction proves they are necessary.

---

### Task 1: Add safe `git switch` validation

**Files:**
- Modify: `/home/aemonge/usr/bin/scoder-git:222-346`

**Interfaces:**
- Consumes: existing `deny`, `deny_run_outside_scoder`, `split_global_options`, and `main` dispatch in `scoder-git`.
- Produces: `validate_switch_args() -> exits 0 for safe branch-only switch args, exits 126 via deny for unsafe args`.

- [ ] **Step 1: Write the failing direct wrapper tests manually before code changes**

Run these commands from `/home/aemonge/usr/bin` before editing. They should show the current failure that safe switch is still blocked.

```bash
tmpdir="$(mktemp -d)" && \
git -C "${tmpdir}" init -q && \
git -C "${tmpdir}" config user.email scoder-validation@example.invalid && \
git -C "${tmpdir}" config user.name 'scoder validation' && \
printf 'base\n' > "${tmpdir}/file.txt" && \
git -C "${tmpdir}" add file.txt && \
git -C "${tmpdir}" commit -m initial -q && \
git -C "${tmpdir}" branch safe-target && \
(cd "${tmpdir}" && SCODER_REAL_GIT="$(command -v git)" /home/aemonge/usr/bin/scoder-git switch safe-target)
```

Expected before implementation: FAIL with output containing `fatal: scoder blocked git switch`.

- [ ] **Step 2: Add `validate_switch_args` to `scoder-git`**

Insert this function after `validate_config_args()` and before `main()`:

```bash
validate_switch_args() {
    local create_mode=0
    local branch_count=0
    local arg

    if [[ $# -eq 0 ]]; then
        deny "git switch without branch"
    fi

    while [[ $# -gt 0 ]]; do
        arg="$1"
        case "${arg}" in
        -)
            branch_count=$((branch_count + 1))
            shift
            ;;
        -c | --create)
            if [[ "${create_mode}" -eq 1 ]]; then
                deny "git switch duplicate create option"
            fi
            if [[ $# -lt 2 ]]; then
                deny "git switch ${arg} without branch"
            fi
            create_mode=1
            branch_count=$((branch_count + 1))
            shift 2
            ;;
        --create=*)
            if [[ "${create_mode}" -eq 1 ]]; then
                deny "git switch duplicate create option"
            fi
            if [[ -z "${arg#--create=}" ]]; then
                deny "git switch --create without branch"
            fi
            create_mode=1
            branch_count=$((branch_count + 1))
            shift
            ;;
        --discard-changes | --force | -f | --detach | --merge | -m | --orphan | --guess | --no-guess | --ignore-other-worktrees | --recurse-submodules | --no-recurse-submodules)
            deny "git switch unsafe option: ${arg}"
            ;;
        --*)
            deny "git switch option not allowlisted: ${arg}"
            ;;
        -*)
            deny "git switch option not allowlisted: ${arg}"
            ;;
        *)
            branch_count=$((branch_count + 1))
            shift
            ;;
        esac
    done

    if [[ "${branch_count}" -ne 1 ]]; then
        deny "git switch expects exactly one branch"
    fi
}
```

- [ ] **Step 3: Wire `switch` through the validator**

Replace this line in the `case "${subcommand}"` dispatch:

```bash
    push | pull | fetch | rebase | reset | clean | merge | cherry-pick | revert | tag | checkout | switch)
```

with these two cases:

```bash
    switch)
        validate_switch_args "${@:2}"
        exec "${real_git}" "${GLOBAL_GIT_ARGS[@]}" "$@"
        ;;
    push | pull | fetch | rebase | reset | clean | merge | cherry-pick | revert | tag | checkout)
```

- [ ] **Step 4: Run direct wrapper tests for allowed switch forms**

Run:

```bash
tmpdir="$(mktemp -d)" && \
git -C "${tmpdir}" init -q && \
git -C "${tmpdir}" config user.email scoder-validation@example.invalid && \
git -C "${tmpdir}" config user.name 'scoder validation' && \
printf 'base\n' > "${tmpdir}/file.txt" && \
git -C "${tmpdir}" add file.txt && \
git -C "${tmpdir}" commit -m initial -q && \
git -C "${tmpdir}" branch safe-target && \
(cd "${tmpdir}" && SCODER_REAL_GIT="$(command -v git)" /home/aemonge/usr/bin/scoder-git switch safe-target) && \
(cd "${tmpdir}" && SCODER_REAL_GIT="$(command -v git)" /home/aemonge/usr/bin/scoder-git switch -c safe-created) && \
(cd "${tmpdir}" && SCODER_REAL_GIT="$(command -v git)" /home/aemonge/usr/bin/scoder-git switch --create safe-created-long) && \
(cd "${tmpdir}" && SCODER_REAL_GIT="$(command -v git)" /home/aemonge/usr/bin/scoder-git switch -) && \
git -C "${tmpdir}" branch --show-current
```

Expected after implementation: PASS, printing the current branch name with no `scoder-git` denial.

- [ ] **Step 5: Run direct wrapper tests for denied switch forms**

Run:

```bash
tmpdir="$(mktemp -d)" && \
git -C "${tmpdir}" init -q && \
git -C "${tmpdir}" config user.email scoder-validation@example.invalid && \
git -C "${tmpdir}" config user.name 'scoder validation' && \
printf 'base\n' > "${tmpdir}/file.txt" && \
git -C "${tmpdir}" add file.txt && \
git -C "${tmpdir}" commit -m initial -q && \
git -C "${tmpdir}" branch safe-target && \
(cd "${tmpdir}" && SCODER_REAL_GIT="$(command -v git)" /home/aemonge/usr/bin/scoder-git switch --force safe-target >/tmp/scoder-force.out 2>&1; test "$?" -eq 126) && \
grep -q 'git switch unsafe option: --force' /tmp/scoder-force.out && \
(cd "${tmpdir}" && SCODER_REAL_GIT="$(command -v git)" /home/aemonge/usr/bin/scoder-git switch --detach HEAD >/tmp/scoder-detach.out 2>&1; test "$?" -eq 126) && \
grep -q 'git switch unsafe option: --detach' /tmp/scoder-detach.out && \
(cd "${tmpdir}" && SCODER_REAL_GIT="$(command -v git)" /home/aemonge/usr/bin/scoder-git switch safe-target extra >/tmp/scoder-extra.out 2>&1; test "$?" -eq 126) && \
grep -q 'git switch expects exactly one branch' /tmp/scoder-extra.out
```

Expected after implementation: PASS; each unsafe command exits 126 and prints a scoder denial.

- [ ] **Step 6: Check syntax**

Run:

```bash
bash -n /home/aemonge/usr/bin/scoder-git
```

Expected: no output and exit code 0.

- [ ] **Step 7: Commit if in a Git checkout**

Run:

```bash
```

Expected in the current environment: FAIL because `/home/aemonge/usr/bin` is not a Git repository. If it prints `true` in a different checkout, commit with:

```bash
git -C /home/aemonge/usr/bin add scoder-git
git -C /home/aemonge/usr/bin commit -m "feat: allow safe git switch in scoder"
```

---

### Task 2: Add sandbox validation tests

**Files:**
- Modify: `/home/aemonge/usr/bin/scoder:973-986`

**Interfaces:**
- Consumes: `scoder-git` `switch` validator from Task 1.
- Produces: `scoder --validate` coverage for safe branch switching and unsafe switch denial inside the bubblewrap sandbox.

- [ ] **Step 1: Add validation cases after Test M.3**

Insert this block after the existing Test M.3 block that ends with `fi` near line 984:

```bash
    info "Test M.4: scoder-git allows safe local branch switching"
    git -C "${test_project}" branch validation-switch-target >/dev/null 2>&1 || true
    local git_switch_result
    git_switch_result=$(OPENCODE_BIN=/bin/bash "${script_path}" -- "${test_project}" -q -x /bin/bash --noprofile --norc -lc 'git switch validation-switch-target >/dev/null && git branch --show-current' 2>&1 || true)
    if [[ "${git_switch_result}" == "validation-switch-target" ]]; then
        echo "✅ Test M.4 PASS: git switch existing branch works"
    else
        echo "❌ Test M.4 FAIL: git switch existing branch failed (${git_switch_result})"
        ((failed_tests++))
    fi

    info "Test M.5: scoder-git allows safe local branch creation"
    local git_switch_create_result
    git_switch_create_result=$(OPENCODE_BIN=/bin/bash "${script_path}" -- "${test_project}" -q -x /bin/bash --noprofile --norc -lc 'git switch -c validation-switch-created >/dev/null && git branch --show-current' 2>&1 || true)
    if [[ "${git_switch_create_result}" == "validation-switch-created" ]]; then
        echo "✅ Test M.5 PASS: git switch -c creates and switches branches"
    else
        echo "❌ Test M.5 FAIL: git switch -c failed (${git_switch_create_result})"
        ((failed_tests++))
    fi

    info "Test M.6: scoder-git blocks unsafe git switch flags"
    local git_switch_force_result
    git_switch_force_result=$(OPENCODE_BIN=/bin/bash "${script_path}" -- "${test_project}" -q -x /bin/bash --noprofile --norc -lc 'git switch --force validation-switch-target 2>&1' 2>&1 || true)
    if echo "${git_switch_force_result}" | grep -q "git switch unsafe option: --force"; then
        echo "✅ Test M.6 PASS: git switch --force is denied"
    else
        echo "❌ Test M.6 FAIL: git switch --force was not denied (${git_switch_force_result})"
        ((failed_tests++))
    fi

    info "Test M.7: scoder-git keeps destructive reset blocked"
    local git_reset_hard_result
    git_reset_hard_result=$(OPENCODE_BIN=/bin/bash "${script_path}" -- "${test_project}" -q -x /bin/bash --noprofile --norc -lc 'git reset --hard HEAD 2>&1' 2>&1 || true)
    if echo "${git_reset_hard_result}" | grep -q "fatal: scoder blocked git reset"; then
        echo "✅ Test M.7 PASS: git reset --hard remains denied"
    else
        echo "❌ Test M.7 FAIL: git reset --hard was not denied (${git_reset_hard_result})"
        ((failed_tests++))
    fi
```

- [ ] **Step 2: Check syntax**

Run:

```bash
bash -n /home/aemonge/usr/bin/scoder
```

Expected: no output and exit code 0.

- [ ] **Step 3: Run focused validation**

Run:

```bash
/home/aemonge/usr/bin/scoder -- /tmp --validate
```

Expected: validation output includes these pass lines:

```text
✅ Test M.4 PASS: git switch existing branch works
✅ Test M.5 PASS: git switch -c creates and switches branches
✅ Test M.6 PASS: git switch --force is denied
✅ Test M.7 PASS: git reset --hard remains denied
```

- [ ] **Step 4: Confirm network/destructive policy remains intact**

Run:

```bash
/home/aemonge/usr/bin/scoder -- /tmp --validate | grep -E 'Test M\.[234567] PASS|validation complete|PASS'
```

Expected: Test M.2 still passes for `git push` denial, Test M.3 still passes for guarded commits, and new Test M.4-M.7 pass.

- [ ] **Step 5: Commit if in a Git checkout**

Run:

```bash
```

Expected in the current environment: FAIL because `/home/aemonge/usr/bin` is not a Git repository. If it prints `true` in a different checkout, commit with:

```bash
git -C /home/aemonge/usr/bin add scoder
git -C /home/aemonge/usr/bin commit -m "test: validate safe scoder git switch"
```

---

### Task 3: Reproduce original worktree failure and decide on reset scope

**Files:**
- Modify only if necessary: `/home/aemonge/usr/bin/scoder-git`
- Modify only if necessary: `/home/aemonge/usr/bin/scoder`

**Interfaces:**
- Consumes: safe `git switch` behavior from Task 1 and validation coverage from Task 2.
- Produces: either a confirmed no-reset-needed outcome, or a follow-up spec/plan for a narrow reset allowance with exact command shape.

- [ ] **Step 1: Capture the failing reset command shape if it still occurs**

Run the original `createworktree` scenario or the closest available command that previously failed. If the tool prints only the high-level denial, run with shell tracing around Git if available:

```bash
SCODER_TRACE_STARTUP=1 createworktree feature/scoder-safe-switch-repro
```

Expected acceptable outcomes:

- The workflow succeeds because safe branch switching is enough.
- The workflow still fails with `fatal: scoder blocked git reset`, and the output identifies the exact reset arguments.

- [ ] **Step 2: Do not add generic reset support**

If the reset arguments are not fully identified, make no `reset` code change. Record the outcome in the final implementation notes as:

```text
git reset remains blocked; safe git switch fallback is now allowed by default.
```

- [ ] **Step 3: If a safe reset shape is identified, stop and request a micro-design update**

Only proceed with reset work after writing a small update to the design that names the exact allowed command form. Do not implement `git reset` allowance in this plan.

Expected: this task normally produces no code changes.

---

## Self-Review

- Spec coverage: Task 1 implements safe branch switching; Task 2 validates allowed and blocked behavior; Task 3 preserves the conservative reset decision.
- Placeholder scan: no placeholders remain; reset work is explicitly excluded unless a new micro-design is approved.
- Type/signature consistency: Bash function `validate_switch_args` is defined before `main` and called only from the `switch)` dispatch case.
