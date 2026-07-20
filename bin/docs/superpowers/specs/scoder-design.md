# scoder Safe Git Branch Switching Design

## Goal

Make `scoder` tolerate safe local branch switching by default while preserving the `scoder-git` safety boundary against destructive, networked, or history-rewriting Git operations.

## Context

`scoder` runs OpenCode inside a bubblewrap sandbox and shadows `/usr/bin/git` with `scoder-git`. The wrapper currently allows read-only Git operations, `git worktree` subcommands, `git add`, and guarded commits, but blanket-blocks branch movement commands such as `git switch` and `git checkout`, plus `git reset`.

This caused a failure flow:

- `createworktree` attempted to create `feature/sav-database-v2`.
- Git created the branch, but worktree setup failed because `scoder-git` blocked `git reset`.
- A fallback `git switch feature/sav-database-v2` also failed because `scoder-git` blocks `git switch`.

The desired behavior is to allow safe local branch switching by default, without making scoder a general-purpose unrestricted Git environment.

## Design

Update `scoder-git` from blanket denial of branch switching to command-specific validation.

### Safe `git switch`

Allow branch-only `git switch` forms by default:

- `git switch <branch>`
- `git switch -c <branch>`
- `git switch --create <branch>`
- `git switch -`

Reject forms that can discard work, detach unexpectedly, or introduce ambiguous behavior:

- `git switch --discard-changes ...`
- `git switch --force ...`
- `git switch -f ...`
- `git switch --detach ...`
- unknown flags
- extra path-like arguments beyond the expected branch name

### Optional branch-only `git checkout`

Support `git checkout` only if needed for compatibility with tooling that still uses the older command. If implemented, allow only branch forms:

- `git checkout <branch>`
- `git checkout -b <branch>`

Reject file restore/pathspec forms and destructive flags:

- `git checkout -- <path>`
- `git checkout <path>` when the argument resolves as a tracked or working-tree path rather than a branch
- `git checkout .`
- `git checkout -f ...`

Because `checkout` is ambiguous, prefer implementing `switch` first and adding `checkout` only if tests or reproduced tooling require it.

### Constrained `git reset`

Allow only the exact reset shape observed during `git worktree add` setup:

- `git reset --hard --no-recurse-submodules`

Reject every other `git reset` form, including:

- `git reset --hard`
- `git reset --mixed`
- `git reset --soft`
- `git reset --merge`
- `git reset --keep`
- `git reset --hard HEAD`
- `git reset --hard -- <path>`
- any reset invocation with paths, revisions, extra flags, or reordered/combined arguments

This is intentionally shape-based because `scoder-git` cannot reliably know whether Git invoked reset from internal worktree setup. The wrapper should therefore allow only the exact no-revision, no-path command that Git emitted for worktree initialization and deny all other reset usage.

## Safety Boundary

Continue blocking by default:

- network operations: `push`, `pull`, unrestricted `fetch`
- history rewrite/integration operations: `rebase`, `merge`, `cherry-pick`, `revert`
- destructive working tree operations: `clean`, hard reset
- tag mutation and other unreviewed Git subcommands

Existing guarded behavior remains unchanged for:

- `git add` path validation
- `git commit` requiring `-m` or `-F`, disabling hooks/editor/GPG inside the wrapper
- safe read-only commands such as `status`, `diff`, `log`, `show`, `branch`, `rev-parse`, and `ls-files`

## Testing

Add or update tests to prove both the newly allowed behavior and preserved blocks.

Allowed cases:

- `git switch <existing-branch>` succeeds.
- `git switch -c <new-branch>` succeeds.
- `git switch --create <new-branch>` succeeds.
- `git switch -` succeeds when a previous branch exists.

Denied cases:

- `git switch --discard-changes <branch>` is blocked.
- `git switch --force <branch>` is blocked.
- `git switch --detach <commit>` is blocked.
- `git reset --hard --no-recurse-submodules` is allowed.
- `git reset --hard` remains blocked.
- `git reset --mixed` remains blocked.
- `git reset --hard HEAD` remains blocked.
- `git reset --hard -- <path>` remains blocked.
- `git push` remains blocked.

Scenario validation:

- Reproduce the original `createworktree` or a reduced equivalent.
- Confirm that safe branch fallback works even if a reset remains blocked.
- Include a test for the exact allowed reset form and separate denial tests for common reset variants.

## Rollout

This is a local script behavior change in `/home/aemonge/usr/bin/scoder-git`, with validation coverage in the scoder test scripts. No OpenCode config schema change is expected. Existing running scoder sessions will keep using the previous mounted wrapper until restarted.
