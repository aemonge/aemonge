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
