#!/usr/bin/env bash

set -Eeuo pipefail

TMPDIR="$(mktemp -d)"
trap 'rm -rf -- "$TMPDIR"' EXIT

MODE="${1:-quick}"
ROOT="${2:-$PWD}"

usage() {
    cat <<'EOF'
Usage: ./scoder-test.sh [quick|full|validate] [ROOT]

Modes:
  quick     Compare key host vs scoder behavior (default)
  full      Include unified diff of full agent output
  validate  Run ./scoder -- --validate only

ROOT defaults to current directory.
EOF
}

agent_names_jq='split("\n") | map(select(test(" \\(")))'
env_filter='^(OPENCODE|SCODER|CLAUDE|NODE|BUN|PNPM|RUSTUP|CARGO|GOPATH|GOBIN|DEBUG|EXPERIMENT|ANTHROPIC|OPENAI|GOOGLE|GITHUB|HTTP_|HTTPS_|NO_PROXY|ALL_PROXY)'

section() {
    printf '\n=== %s ===\n' "$1"
}

show_agent_names() {
    local title="$1"
    shift
    section "$title"
    "$@" | jq -R -s "$agent_names_jq"
}

show_env() {
    local title="$1"
    shift
    section "$title"
    "$@" | /usr/bin/grep -E "$env_filter" | sort || true
}

run_validate_only() {
    exec ./scoder -- --validate
}

run_quick() {
    section "HOST: opencode binary"
    command -v opencode
    readlink -f "$(command -v opencode)" 2>/dev/null || command -v opencode
    opencode --version 2>/dev/null || true

    section "SCODER: opencode binary"
    scoder -- "$ROOT" -x /bin/bash -lc 'command -v opencode; readlink -f "$(command -v opencode)" 2>/dev/null || command -v opencode; opencode --version 2>/dev/null || true'

    section "HOST: rust/cargo homes"
    /bin/bash -lc 'printf "RUSTUP_HOME=%s\nCARGO_HOME=%s\n" "${RUSTUP_HOME:-}" "${CARGO_HOME:-}"; command -v cargo || true; cargo --version 2>/dev/null || true'

    section "SCODER: rust/cargo homes"
    scoder -- "$ROOT" -x /bin/bash -lc 'printf "RUSTUP_HOME=%s\nCARGO_HOME=%s\n" "${RUSTUP_HOME:-}" "${CARGO_HOME:-}"; command -v cargo || true; cargo --version 2>/dev/null || true'

    section "HOST: git root"
    git rev-parse --show-toplevel 2>/dev/null || true

    section "SCODER: git root"
    scoder -- "$ROOT" -x /bin/bash -lc 'git rev-parse --show-toplevel 2>/dev/null || true'

    show_agent_names "HOST agent names" opencode agent list
    show_agent_names "SCODER agent names" scoder agent list -- "$ROOT"

    show_env "HOST relevant env vars" env
    show_env "SCODER relevant env vars" scoder -- "$ROOT" -x /bin/bash -lc env
}

run_full() {
    run_quick

    section "HOST: plugin package dirs"
    /usr/bin/find -L "$HOME/.cache/opencode/packages" -maxdepth 2 -type d -print 2>/dev/null | sort

    section "SCODER: plugin package dirs"
    scoder -- "$ROOT" -x /bin/bash -lc '/usr/bin/find -L "$HOME/.cache/opencode/packages" -maxdepth 2 -type d -print 2>/dev/null | sort'

    section "FULL agent list diff"
    local host_agents="$TMPDIR/host-agents.txt"
    local scoder_agents="$TMPDIR/scoder-agents.txt"

    opencode agent list > "$host_agents"
    scoder agent list -- "$ROOT" > "$scoder_agents"

    printf -- '--- host agents file: %s\n' "$host_agents"
    printf -- '--- scoder agents file: %s\n' "$scoder_agents"
    diff -u "$host_agents" "$scoder_agents" || true
}

case "$MODE" in
quick)
    run_quick
    ;;
full)
    run_full
    ;;
validate)
    run_validate_only
    ;;
-h|--help|help)
    usage
    ;;
*)
    printf 'Unknown mode: %s\n\n' "$MODE" >&2
    usage >&2
    exit 1
    ;;
esac
