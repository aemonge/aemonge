#!/bin/bash

set -e

arch_packages() {
  ./arch-packages.sh
}

font() {
  ./fonts.sh
}

pcloud() {
  ./pcloud.sh
}

mkdirs() {
  # Base directory containing the .directory files
  dir_settings="$HOME/usr/configs/directories"

  # Create directories and symlink their .directory settings
  for dir_file in "$dir_settings"/*.directory; do
    # Extract directory name from the .directory filename
    dir_name=$(basename "$dir_file" .directory)

    mkdir -p "$HOME/$dir_name"

    # Create a symlink for the .directory file
    ln -sf "$dir_settings/$dir_name.directory" "$HOME/$dir_name/.directory"
  done
}

dot-files() {
    local base_path="$HOME/usr/configs/dot-files"
    local dirs

    # Populate dirs array using mapfile
    mapfile -t dirs < <(find "$base_path" -maxdepth 1 -mindepth 1 -type d -exec basename {} \;)

    for dir in "${dirs[@]}"; do
        local file
        local dotfile_name

        # Loop through the hidden files (dot-files) in the current directory
        for file in "$base_path/$dir"/.*; do
            # Extract the basename to get the dotfile name (e.g., .zshrc)
            dotfile_name=$(basename "$file")

            # Ensure it's a regular file and not '.' or '..'
            if [[ -f "$file" && "$dotfile_name" != "." && "$dotfile_name" != ".." ]]; then
                # Remove any existing dotfile in the home directory, ignoring errors
                rm "$HOME/$dotfile_name" 2>/dev/null

                # Create a symbolic link to the new dotfile
                ln -s "$file" "$HOME/$dotfile_name"
            fi
        done
    done
}

local-configs() {
    local base_path="$HOME/usr/configs/local-configs"
    local target_path="$HOME/.config"
    local dirs

    # Populate dirs array using mapfile
    mapfile -t dirs < <(find "$base_path" -maxdepth 1 -mindepth 1 -type d -exec basename {} \;)

    for dir in "${dirs[@]}"; do
        # If the target directory exists, remove it
        if [[ -d "${target_path:?}/$dir" || -L "${target_path:?}/$dir" || -f "${target_path:?}/$dir" ]]; then
            echo rm -rf "${target_path:?}/$dir"

            # Clear cache, share, and state directories for the config
            echo rm -rf "${HOME:?}/.cache/$dir" 2>/dev/null
            echo rm -rf "${HOME:?}/.local/share/$dir" 2>/dev/null
            echo rm -rf "${HOME:?}/.local/state/$dir" 2>/dev/null
        fi

        # Create a symbolic link for the directory
        echo ln -s "${base_path:?}/$dir" "${target_path:?}/"
    done
}

bins() {
  # Ensure ~/.local/bin exists
  mkdir -p ~/.local/bin

  # Link binaries
  for bin in ~/usr/bin/*; do
      ln -sf "$bin" ~/.local/bin/
  done
}

kde() {
  if command -v konsave &>/dev/null && [[ -f "${HOME:?}/media/deck.knsv" ]]; then
    konsave -i "${HOME:?}/media/deck.knsv"
    konsave -a deck
  fi
}

firefox(){
  firefox_profile_dir="$HOME/.mozilla/firefox"
  chrome_file_path="$HOME/usr/configs/firefox/chrome/userChrome.css"

  # Search for .default or .dev-edition-default directories
  for profile in "$firefox_profile_dir"/*.default*; do
      # Check if the chrome directory exists in the profile and create it if not
      if [ ! -d "$profile/chrome" ]; then
          mkdir "$profile/chrome"
      fi

      # Link the userChrome.css file
      ln -sf "$chrome_file_path" "$profile/chrome/userChrome.css"

      # Exiting after linking the first found profile; remove this break if you want to apply to all profiles
      # break
  done
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
        echo "Usage: $0 {arch-packages|font|mkdirs|dot-files|local-configs|pcloud|kde|firefox|--all}"
        exit 1
        ;;
esac
