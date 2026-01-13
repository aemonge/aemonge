#!/usr/bin/env bash

# MISE Migration: Assessment + Cleanup Commands
# Single script to assess your system and provide actionable cleanup

set -e

echo "======================================================="
echo "  MISE Migration Tool - Assessment & Cleanup"
echo "======================================================="
echo ""

# Color codes for better visibility
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Storage for findings
declare -a FOUND_MANAGERS=()
declare -a FOUND_DIRS=()
declare -a PATH_ISSUES=()
TOTAL_SIZE=0

# Function to check if command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Function to check directory and calculate size
check_dir() {
    if [ -d "$1" ]; then
        local size=$(du -sh "$1" 2>/dev/null | cut -f1)
        local size_mb=$(du -sm "$1" 2>/dev/null | cut -f1)
        FOUND_DIRS+=("$1|$size")
        TOTAL_SIZE=$((TOTAL_SIZE + size_mb))
        return 0
    fi
    return 1
}

echo -e "${BLUE}## STEP 1: System Assessment${NC}"
echo "=================================="
echo ""

# Check for environment managers
echo "Checking for old environment managers..."
if command_exists rustup; then
    FOUND_MANAGERS+=("rustup|$(which rustup)")
    echo -e "  ${YELLOW}⚠️ ${NC}  Found: rustup at $(which rustup)"
fi

if command_exists pyenv; then
    FOUND_MANAGERS+=("pyenv|$(which pyenv)")
    echo -e "  ${YELLOW}⚠️ ${NC}  Found: pyenv at $(which pyenv)"
fi

if command_exists rbenv; then
    FOUND_MANAGERS+=("rbenv|$(which rbenv)")
    echo -e "  ${YELLOW}⚠️ ${NC}  Found: rbenv at $(which rbenv)"
fi

if command_exists nvm; then
    FOUND_MANAGERS+=("nvm|$(which nvm)")
    echo -e "  ${YELLOW}⚠️ ${NC}  Found: nvm at $(which nvm)"
fi

if [ ${#FOUND_MANAGERS[@]} -eq 0 ]; then
    echo -e "  ${GREEN}✅ ${NC} No old environment managers found"
fi
echo ""

# Check for data directories
echo "Checking for old data directories..."
check_dir "$HOME/.rustup" && echo -e "  ${YELLOW}⚠️ ${NC}  Found: ~/.rustup ($(du -sh ~/.rustup 2>/dev/null | cut -f1))"
check_dir "$HOME/.cargo" && echo -e "  ${YELLOW}⚠️ ${NC}  Found: ~/.cargo ($(du -sh ~/.cargo 2>/dev/null | cut -f1))"
check_dir "$HOME/.pyenv" && echo -e "  ${YELLOW}⚠️ ${NC}  Found: ~/.pyenv ($(du -sh ~/.pyenv 2>/dev/null | cut -f1))"
check_dir "$HOME/.go" && echo -e "  ${YELLOW}⚠️ ${NC}  Found: ~/.go ($(du -sh ~/.go 2>/dev/null | cut -f1))"
check_dir "$HOME/.nvm" && echo -e "  ${YELLOW}⚠️ ${NC}  Found: ~/.nvm ($(du -sh ~/.nvm 2>/dev/null | cut -f1))"
check_dir "$HOME/.rbenv" && echo -e "  ${YELLOW}⚠️ ${NC}  Found: ~/.rbenv ($(du -sh ~/.rbenv 2>/dev/null | cut -f1))"

if [ ${#FOUND_DIRS[@]} -eq 0 ]; then
    echo -e "  ${GREEN}✅ ${NC} No old data directories found"
fi
echo ""

# Check PATH
echo "Checking PATH for problematic entries..."
IFS=':' read -ra PATHS <<< "$PATH"
for p in "${PATHS[@]}"; do
    case "$p" in
        *cargo/bin*|*rustup*|*pyenv*|*nvm*|*rbenv*)
            PATH_ISSUES+=("$p")
            echo -e "  ${YELLOW}⚠️ ${NC}  Found in PATH: $p"
            ;;
    esac
done

if [ ${#PATH_ISSUES[@]} -eq 0 ]; then
    echo -e "  ${GREEN}✅ ${NC} No problematic PATH entries found"
fi
echo ""

# Check mise status
echo "Checking mise installation..."
if command_exists mise; then
    echo -e "  ${GREEN}✅ ${NC} mise installed: $(which mise)"
    echo -e "  ${GREEN}✅ ${NC} mise version: $(mise --version)"

    # Check for updates
    CURRENT_VERSION=$(mise --version | grep -oP '\d{4}\.\d+\.\d+' | head -1)
    echo ""
    echo -e "  ${BLUE}ℹ️${NC}   Global tools installed:"
    mise ls -g 2>/dev/null | tail -n +2 | sed 's/^/    /'
else
    echo -e "  ${RED}❌${NC} mise not found - install it first!"
    exit 1
fi
echo ""
echo ""

# Generate cleanup commands
echo -e "${BLUE}## STEP 2: Cleanup Actions${NC}"
echo "=================================="
echo ""

if [ ${#FOUND_MANAGERS[@]} -eq 0 ] && [ ${#FOUND_DIRS[@]} -eq 0 ]; then
    echo -e "${GREEN}✅  Your system is clean! No cleanup needed.${NC}"
    echo ""
    echo "Optional: Update mise if needed"
    echo "  mise self-update"
    exit 0
fi

echo -e "${YELLOW}⚠️   Items found that can be cleaned up${NC}"
echo ""
echo "💾 Total disk space to reclaim: ~$((TOTAL_SIZE / 1024)) GB"
echo ""

echo "================================================"
echo "📋 COPY AND PASTE THESE COMMANDS TO CLEAN UP"
echo "================================================"
echo ""

echo "## 1  CREATE BACKUP FIRST (RECOMMENDED!)"
echo "## --------------------------------------"
echo "mkdir -p ~/mise_migration_backup"

# Generate backup commands for found directories
for dir_info in "${FOUND_DIRS[@]}"; do
    dir=$(echo "$dir_info" | cut -d'|' -f1)
    echo "cp -r $dir ~/mise_migration_backup/ 2>/dev/null || true"
done

echo "echo '✅  Backups created in ~/mise_migration_backup'"
echo ""
echo ""

echo "## 2  INSTALL RUNTIMES VIA MISE (Do this BEFORE removing old ones!)"
echo "## -----------------------------------------------------------------"

# Check which runtimes need to be installed
needs_rust=false
needs_python=false
needs_go=false
needs_node=false

for dir_info in "${FOUND_DIRS[@]}"; do
    dir=$(echo "$dir_info" | cut -d'|' -f1)
    case "$dir" in
        *rustup*|*cargo*) needs_rust=true ;;
        *pyenv*) needs_python=true ;;
        *go*) needs_go=true ;;
        *nvm*) needs_node=true ;;
    esac
done

if [ "$needs_rust" = true ]; then
    echo "mise use -g rust@stable"
fi
if [ "$needs_python" = true ]; then
    echo "mise use -g python@latest uv@latest"
fi
if [ "$needs_go" = true ]; then
    echo "mise use -g go@latest"
fi
if [ "$needs_node" = true ]; then
    echo "mise use -g node@lts"
fi

echo ""
echo "# Verify installations work"
echo "mise ls -g"

if [ "$needs_rust" = true ]; then echo "rustc --version"; fi
if [ "$needs_python" = true ]; then echo "python --version"; fi
if [ "$needs_go" = true ]; then echo "go version"; fi
if [ "$needs_node" = true ]; then echo "node --version"; fi

echo ""
echo ""

echo "## 3  REMOVE OLD SYSTEM PACKAGES (Arch/Manjaro)"
echo "## ---------------------------------------------"

for manager_info in "${FOUND_MANAGERS[@]}"; do
    manager=$(echo "$manager_info" | cut -d'|' -f1)
    echo "pamac remove -o $manager"
done

echo ""
echo ""

echo "## 4  DELETE OLD DATA DIRECTORIES"
echo "## -------------------------------"
echo "## ⚠️   ONLY RUN AFTER STEP 2 AND 3 COMPLETE SUCCESSFULLY!"
echo ""

for dir_info in "${FOUND_DIRS[@]}"; do
    dir=$(echo "$dir_info" | cut -d'|' -f1)
    size=$(echo "$dir_info" | cut -d'|' -f2)
    echo "rm -rf $dir  # 💾 Frees up $size"
done

echo ""
echo ""

echo "## 5  UPDATE MISE"
echo "## ---------------"
echo "mise self-update"
echo ""
echo ""

echo "## 6  VERIFY EVERYTHING WORKS"
echo "## ---------------------------"
echo "mise doctor"
echo "mise ls -g"
echo ""
echo "# Test that old paths are gone"
echo "echo \$PATH | tr ':' '\n' | grep -E "(cargo|rustup|pyenv|nvm)" || echo '✅  PATH is clean!'"
echo ""
echo ""

echo "## 7  OPTIONAL: Remove backup after a few days"
echo "## --------------------------------------------"
echo "# rm -rf ~/mise_migration_backup"
echo ""

echo ""
echo -e "${GREEN}================================================${NC}"
echo -e "${GREEN}✨ Copy commands above and execute step by step${NC}"
echo -e "${GREEN}================================================${NC}"
