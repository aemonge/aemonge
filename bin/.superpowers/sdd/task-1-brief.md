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

