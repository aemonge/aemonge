#!/bin/bash

pcloud () {
    echo "Downloading and installing pCloud..."

    # Directory to save the binary
    local dir="$HOME/opt"
    mkdir -p "$dir"

    # Downloading and setting permissions
    pushd "$dir" || (echo "Error: Failed to pushd $dir" && exit 1)
    curl -L "https://www.pcloud.com/how-to-install-pcloud-drive-linux.html?download=electron-64" -o pcloud
    chmod +x pcloud
    popd || (echo "Error: Failed to popd" && exit 1)

    # Ensure local bin exists
    mkdir -p "$HOME/.local/bin"

    # Create symlink if it doesn't already exist
    [ -e "$HOME/.local/bin/pcloud" ] || ln -s "$dir/pcloud" "$HOME/.local/bin/pcloud"

    # Run pcloud
    "$dir/pcloud"

    echo "pCloud installed successfully."
}

pcloud
