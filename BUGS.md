# Known Bugs

## spi validation: Pi XDG config/data resources missing

- **Status:** Open
- **Observed:** `spi -- --validate` fails Test E.11 with `Pi XDG config/data resource policy failed`.
- **Reproduction snippet:**
  ```console
  spi -- --validate
  # Test E.11 FAIL: Pi XDG config/data resource policy failed
  ```
- **Current evidence:** The validation fixture/run did not provide the expected sandbox paths:
  - `${HOME}/.config/pi/config.toml`
  - `${HOME}/.local/share/pi/resource.txt`
- **Next investigation notes:** This is likely a Pi-specific XDG/resource mount or validation fixture issue. Check how `bind_pi_xdg_resources` maps host XDG config/data into the sandbox HOME during validation. Do not chase OpenCode `.opencode` paths for this failure.

## spi validation: Pi XDG state/cache dirs not writable

- **Status:** Open
- **Observed:** `spi -- --validate` fails Test E.12 with `Pi XDG state/cache dirs are writable without broad XDG exposure`.
- **Reproduction snippet:**
  ```console
  spi -- --validate
  # Test E.12 FAIL: Pi XDG state/cache dirs are writable without broad XDG exposure
  ```
- **Current evidence:** The validation fixture/run did not provide the expected writable sandbox path:
  - `${HOME}/.local/state/pi/status`
- **Next investigation notes:** Inspect Pi-specific XDG state/cache bind creation and the validation fixture's expected HOME-relative state path. This appears related to Pi status/resource mounts, not OpenCode path handling.

## spi interactive footer misses plain pi segment

- **Status:** Open
- **Observed:** Interactive `spi` still misses the plain `pi` footer segment.
- **Reproduction snippet:**
  ```console
  pi
  # footer includes: 󰈙 ◷ check-os TOML config ▱▱▱▱▱ 0/8  1.1

  spi
  # footer shows folder/model/context but not the plain pi segment above
  ```
- **Next investigation notes:** Compare the Pi status/footer resources and writable state visible to plain `pi` versus `spi`. Start with Pi-specific statusline/state/resource mounts and socket/status inheritance. Do not broaden the investigation into OpenCode `.opencode` paths unless new evidence directly implicates them.
