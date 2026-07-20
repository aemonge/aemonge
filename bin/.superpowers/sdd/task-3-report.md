# Task 3 Report

## Status

COMPLETED (investigation-only).

## Summary

I reproduced the original failure path in this environment via the closest equivalent command path. `git worktree add` (the operation used by the create-worktree flow) still fails because `scoder-git` blocks an internal `git reset --hard --no-recurse-submodules` invocation.

## Commands run and outputs

- `command -v createworktree || which createworktree || type createworktree` via `bash -lc`
  - Output: `createworktree: not found` (no standalone `createworktree` CLI command available in this environment).

- Repro command (closest available):
  - `bash -lc 'git init ...; /home/aemonge/usr/bin/scoder-git worktree add "${tmp}/wt" -b "feature/scoder-safe-switch-repro" main'`
  - Exit: `128`
  - Output (excerpt):
    - `Preparing worktree (new branch 'feature/scoder-safe-switch-repro')`
    - `fatal: scoder blocked git reset; no reset was performed`
    - `fatal: run git reset outside scoder if you really want to reset`

- Same repro with trace to capture exact inner command:
  - `bash -lc 'GIT_TRACE=1 /home/aemonge/usr/bin/scoder-git worktree add ...'`
  - Output line: `run-command.c:673 ... start_command: /usr/lib/git-core/git reset --hard --no-recurse-submodules`

- Repro with explicit real git backend (`SCODER_REAL_GIT=/bin/git`) showed the same block behavior and identical messages/exit code.

## Conclusion

- `createworktree` CLI could not be run directly (not present in PATH here).
- Closest-equivalent flow confirms the failure is real and repeatable under current wrapper policy.
- Identified exact blocked command shape: `git reset --hard --no-recurse-submodules` (as emitted by Git trace during worktree creation).

## Micro-design update needed?

Yes — this is a candidate for a follow-up micro-design update before any reset allowance is implemented, since the exact command shape is now known and narrowly scoped.
