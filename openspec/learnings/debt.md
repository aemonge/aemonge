# Debt

Routed items from change verdicts. Each line: date · change · item · disposition.

- 2026-10-30 · fix-devbox-auto-mount-project-collision · `git mv` is not in
  the devbox-git allowlist (denied as unknown command shape; `mv` +
  `git add -A` used instead — identical local effect). Open human decision:
  add `git mv` to the wrapper allowlist with tests, or accept mv+add as the
  standard move flow.
- 2026-10-30 · fix-devbox-auto-mount-project-collision · `~/.local/bin` is
  ro-bound inside devbox sandboxes (host-tools policy), so symlink repoints
  after script moves are always a host-side one-liner. Inherent boundary, not
  a defect; noted so future moves hand the one-liner over proactively.
