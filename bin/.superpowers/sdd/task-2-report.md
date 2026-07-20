Task status: completed

One-line summary: Added scoder validation tests M.4-M.7 in `scoder` to cover safe branch switching, safe branch creation, and enforcement of existing unsafe `git switch --force` and `git reset --hard` blocks.

Test command summary:
- `bash -n /home/aemonge/usr/bin/scoder` ✅ (exit 0)
- `bash -lc '/home/aemonge/usr/bin/scoder -- /tmp --validate'` ⚠️ (fails in this environment: bubblewrap namespace restriction before sandbox tests execute)
- `bash -lc '/home/aemonge/usr/bin/scoder -- /tmp --validate | grep -E "Test M\.[234567] PASS|validation complete|PASS"'` ⚠️ (environment prevents full validation; only early lines emitted)
- `bash -lc 'HOME=/home/aemonge /home/aemonge/usr/bin/scoder -- /tmp --validate'` ⚠️ (same sandbox restriction)

Concerns:
- Full `--validate` suite cannot complete in current sandboxed execution environment because bubblewrap cannot create namespaces (`HOME` isolation fails before M-tests).
- New tests likely pass in normal host shell if Task 1 validation behavior is present; pass-by-pass can be confirmed once run outside restricted container.
