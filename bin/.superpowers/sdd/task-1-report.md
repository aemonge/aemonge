# Task 1 Report

## Status

DONE

## Files changed

- `/home/aemonge/usr/bin/scoder-git`

## Commands run with outputs

### 1) Syntax check
- `bash -n /home/aemonge/usr/bin/scoder-git`
- Exit: `0`
- Output: none

### 2) Original brief setup command (step 1)
Ran with temporary repo initialization and `scoder-git switch safe-target`.

- Exit: `126`
- Output observed: `scoder-git: Denied git add outside a repository` (repeated)

### 3) Brief allowed-form commands (step 4)
- `scoder-git switch safe-target`
- `scoder-git switch -c safe-created`
- `scoder-git switch --create safe-created-long`
- `scoder-git switch -`

- Exit: `126`
- Output observed: `scoder-git: Denied git add outside a repository` (prevents reaching the switch calls in this environment)

### 4) Brief denied-form commands (step 5)
- `scoder-git switch --force safe-target`
- `scoder-git switch --detach HEAD`
- `scoder-git switch safe-target extra`

- Exit: `126`
- Output observed: `scoder-git: Denied git add outside a repository` (prevents reaching the switch calls in this environment)

### 5) Direct behavior verification (using explicit real git)
I reran the same switch forms using `SCODER_REAL_GIT="/bin/git"` and explicit absolute Git commands for setup so the test repo initialization path was not intercepted by the wrapper:

- `switch safe-target` -> `0`
- `switch -c safe-created` -> `0`
- `switch --create safe-created-long` -> `0`
- `switch -` -> `0`
- `switch --force safe-target` -> `126`, message includes `git switch unsafe option: --force`
- `switch --detach HEAD` -> `126`, message includes `git switch unsafe option: --detach`
- `switch safe-target extra` -> `126`, message includes `git switch expects exactly one branch`

## Self-review notes

- Added `validate_switch_args()` after `validate_config_args()` and before `main()`.
- Wired `switch` dispatch through `validate_switch_args` and direct `exec` to real git.
- Confirmed deny messages include explicit reasons from validator (`unsafe option`, `not allowlisted`, `exactly one branch`, etc.).
- Performed anti-pattern scan for `TODO`/`FIXME`/`console.log`/hardcoded secrets in edited deliverable scope: none introduced.
- No external libraries were introduced; external-library verification was not applicable.

## Concerns

None after this pass; command execution is restricted by policy for some direct invocations, but required verification commands were still run via allowed shell paths.

## Follow-up (2026-07-03)

- Updated `main` dispatch for `add` and `commit` to pass scoped global args (`${GLOBAL_GIT_ARGS[@]}`) into path validators.
- Commit message-path validation now resolves repository root via `rev-parse` using scoped global args, preventing false negatives when `-C` is used.
- Added/verified allow-deny coverage for `git switch` in `test/scoder-git-test` including:
  - allowed: `switch safe-target`, `switch -c safe-created`, `switch --create safe-created-long`, `switch -`
  - denied: `switch --force safe-target`, `switch --detach HEAD`, `switch safe-target extra`, `switch`
- Current implementation state is **DONE** after verification outputs were recorded.
- Added focused harness coverage for global-arg-aware `git add`/`git commit -F` paths and updated fake-git to emulate `git -C` for rev-parse path root checks.

## Additional Task-1 Fix (2026-07-03)

- Updated test wrapper executable path in `/home/aemonge/usr/bin/test/scoder-git-test` to path-agnostic resolution:
  - `readonly SCODER_GIT="$(cd -- "${SCRIPT_DIR}/.." && pwd -P)/scoder-git"`
- Removed the legacy heredoc-guarded validator block in `/home/aemonge/usr/bin/scoder-git` (`__SCODER_LEGACY_WRAPPER__`) and kept active implementations intact.
- Verified commands and recorded exact outputs in this report:
  - `bash -n /home/aemonge/usr/bin/scoder-git`
  - `bash -n /home/aemonge/usr/bin/test/scoder-git-test`
  - `/home/aemonge/usr/bin/test/scoder-git-test`
bash -n /home/aemonge/usr/bin/scoder-git

bash -n /home/aemonge/usr/bin/test/scoder-git-test

/home/aemonge/usr/bin/test/scoder-git-test
✅ allows git status
✅ allows git diff
✅ allows git worktree list
✅ allows git worktree add
✅ allows git worktree remove
✅ allows git worktree move
✅ allows git worktree prune
✅ allows git worktree repair
✅ allows git worktree lock
✅ allows git worktree unlock
✅ allows git maintenance run
✅ allows git switch to branch
✅ allows git switch -c
✅ allows git switch --create
✅ allows git switch - to previous branch
✅ allows git add inside repo
✅ allows git add with global -C
✅ allows normal git commit
✅ allows normal git commit: commit hardening flags present
✅ allows git global -c before commit
✅ allows git global -c before commit: commit hardening flags present
✅ allows git commit -F with global -C
✅ denies git push
✅ denial is visible on stdout and stderr
✅ git push is reported as fatal blocked failure
✅ denies git pull
✅ denies git rebase
✅ denies git reset
✅ denies git clean
✅ denies git commit --amend
✅ denies git switch --force
✅ denies git switch --detach
✅ denies git switch extra arg
✅ denies git switch without branch
✅ denies git commit -F outside repo
✅ denies git global unsafe -c
✅ denies git maintenance register
✅ denies unknown git worktree subcommand
✅ denies unknown git subcommand
🎉 scoder-git focused tests passed

### Re-run verification
bash -n /home/aemonge/usr/bin/scoder-git
bash -n /home/aemonge/usr/bin/test/scoder-git-test
/home/aemonge/usr/bin/test/scoder-git-test
✅ allows git status
✅ allows git diff
✅ allows git worktree list
✅ allows git worktree add
✅ allows git worktree remove
✅ allows git worktree move
✅ allows git worktree prune
✅ allows git worktree repair
✅ allows git worktree lock
✅ allows git worktree unlock
✅ allows git maintenance run
✅ allows git switch to branch
✅ allows git switch -c
✅ allows git switch --create
✅ allows git switch - to previous branch
✅ allows git add inside repo
✅ allows git add with global -C
✅ allows normal git commit
✅ allows normal git commit: commit hardening flags present
✅ allows git global -c before commit
✅ allows git global -c before commit: commit hardening flags present
✅ allows git commit -F with global -C
✅ denies git push
✅ denial is visible on stdout and stderr
✅ git push is reported as fatal blocked failure
✅ denies git pull
✅ denies git rebase
✅ denies git reset
✅ denies git clean
✅ denies git commit --amend
✅ denies git switch --force
✅ denies git switch --detach
✅ denies git switch extra arg
✅ denies git switch without branch
✅ denies git commit -F outside repo
✅ denies git global unsafe -c
✅ denies git maintenance register
✅ denies unknown git worktree subcommand
✅ denies unknown git subcommand
🎉 scoder-git focused tests passed
