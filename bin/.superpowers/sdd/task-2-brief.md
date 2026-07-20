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

