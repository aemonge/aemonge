#!/bin/bash

log_error() {
    echo "[ERROR] $1" 1>&2
}

arch_packages() {
    echo "Installing Arch packages..."
    ./arch-packages.sh || log_error "Failed to install Arch packages"
}

font() {
    echo "Setting up fonts..."
    ./fonts.sh || log_error "Failed to setup fonts"
}

pcloud() {
    echo "Setting up pCloud..."
    ./pcloud.sh || log_error "Failed to setup pCloud"
}

mkdirs() {
    echo "Setting up directories..."
    local dir_settings="$HOME/usr/configs/directories"

    # Create directories and symlink their .directory settings
    for dir_file in "$dir_settings"/*.directory; do
        local dir_name=$(basename "$dir_file" .directory)

        mkdir -p "$HOME/$dir_name" || log_error "Failed to create directory $HOME/$dir_name"

        ln -sf "$dir_settings/$dir_name.directory" "$HOME/$dir_name/.directory" || log_error "Failed to symlink $dir_name.directory"
    done
}

dot-files() {
    echo "Setting up dot-files..."
    local base_path="$HOME/usr/configs/dot-files"
    local dirs

    mapfile -t dirs < <(find "$base_path" -maxdepth 1 -mindepth 1 -type d -exec basename {} \;)

    for dir in "${dirs[@]}"; do
        local file
        local dotfile_name

        for file in "$base_path/$dir"/.*; do
            dotfile_name=$(basename "$file")

            if [[ -f "$file" && "$dotfile_name" != "." && "$dotfile_name" != ".." ]]; then
                rm "$HOME/$dotfile_name" 2>/dev/null || log_error "Failed to remove $HOME/$dotfile_name"

                ln -s "$file" "$HOME/$dotfile_name" || log_error "Failed to symlink $dotfile_name"
            fi
        done
    done
}

local-configs() {
    echo "Setting up local configurations..."
    local base_path="$HOME/usr/configs/local-configs"
    local target_path="$HOME/.config"
    local dirs

    mapfile -t dirs < <(find "$base_path" -maxdepth 1 -mindepth 1 -type d -exec basename {} \;)

    for dir in "${dirs[@]}"; do
        if [[ -d "${target_path:?}/$dir" || -L "${target_path:?}/$dir" || -f "${target_path:?}/$dir" ]]; then
            rm -rf "${target_path:?}/$dir" || log_error "Failed to remove ${target_path:?}/$dir"

            rm -rf "${HOME:?}/.cache/$dir" 2>/dev/null
            rm -rf "${HOME:?}/.local/share/$dir" 2>/dev/null
            rm -rf "${HOME:?}/.local/state/$dir" 2>/dev/null
        fi

        ln -s "${base_path:?}/$dir" "${target_path:?}/" || log_error "Failed to symlink ${base_path:?}/$dir"
    done
}

bins() {
    echo "Setting up binaries..."
    mkdir -p ~/.local/bin || log_error "Failed to create ~/.local/bin directory"

    for bin in ~/usr/bin/*; do
        ln -sf "$bin" ~/.local/bin/ || log_error "Failed to symlink binary from ~/usr/bin"
    done
}

kde() {
    echo "Setting up KDE configurations..."
    if command -v konsave &>/dev/null && [[ -f "${HOME:?}/media/deck.knsv" ]]; then
        konsave -i "${HOME:?}/media/deck.knsv" || log_error "Failed to import KDE configuration"
        konsave -a deck || log_error "Failed to apply KDE theme"
    fi
}

firefox() {
    echo "Setting up Firefox configurations..."
    local firefox_profile_dir="$HOME/.mozilla/firefox"
    local chrome_dir_path="$HOME/usr/configs/saved-configs/firefox/chrome"

    # Use find to get the directories
    while IFS= read -r profile; do
        echo "Processing: $profile"

        # Check and remove existing chrome directory or symlink
        if [ -d "$profile/chrome" ] || [ -L "$profile/chrome" ]; then
            rm -rf "$profile/chrome"
        fi

        # Create symlink for the entire chrome directory
        ln -sfv "$chrome_dir_path" "$profile/"
    done < <(find "$firefox_profile_dir" -maxdepth 1 -type d -name "*default")
}

# Parse arguments and call functions accordingly
case "$1" in
    --all)
        arch_packages
        font
        mkdirs
        dot-files
        local-configs
        bins
        pcloud
        kde
        firefox
        ;;
    arch-packages) arch_packages ;;
    font) font ;;
    mkdirs) mkdirs ;;
    dot-files) dot-files ;;
    local-configs) local-configs ;;
    bins) bins ;;
    pcloud) pcloud ;;
    kde) kde ;;
    firefox) firefox ;;
    *)
        echo "Usage: $0 {arch-packages|font|mkdirs|dot-files|local-configs|bins|pcloud|kde|firefox|--all}"
        exit 1
        ;;
esac
