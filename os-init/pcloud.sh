#!/bin/bash

set -e

# Directory to save the binary
dir="$HOME/opt"
mkdir -p "$dir"

# Downloading and setting permissions
pushd "$dir"
curl -L "https://www.pcloud.com/how-to-install-pcloud-drive-linux.html?download=electron-64" -o pcloud
chmod +x pcloud
popd

# Ensure local bin exists
mkdir -p "$HOME/.local/bin"

# Create symlink if it doesn't already exist
[ -e "$HOME/.local/bin/pcloud" ] || ln -s "$dir/pcloud" "$HOME/.local/bin/pcloud"

# Run pcloud
"$dir/pcloud"
