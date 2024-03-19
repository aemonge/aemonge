#!/bin/bash

# Rclone remote name
REMOTE="pcloud"

# Directories to synchronize
declare -A DIRS
DIRS["$HOME/customizations"]="/customizations"
DIRS["$HOME/documents"]="/documents"
DIRS["$HOME/ebooks"]="/ebooks"
DIRS["$HOME/images"]="/images"
DIRS["$HOME/pictures"]="/pictures"
DIRS["$HOME/public"]="/public"
DIRS["$HOME/stash"]="/stash"
DIRS["$HOME/studies"]="$HOME/studies/UNED"

# Function to run rclone sync
sync_to_pcloud() {
    local src=$1
    local dest=$2
    rclone sync "$src" "$REMOTE:$dest"

    # Sync from local to remote
    rclone sync "$src" "$REMOTE:$dest" --update
    # Sync from remote to local
    rclone sync "$REMOTE:$dest" "$src" --update
}

# Watch directories and sync changes
for SRC in "${!DIRS[@]}"; do
    while inotifywait -r -e modify,create,delete,move "$SRC"; do
        sync_to_pcloud "$SRC" "${DIRS[$SRC]}"
    done &
done

# Run ~/cloud all the cloud files deamonized
rclone mount pcloud:/ ~/cloud --daemon --vfs-cache-mode full

# Wait for all background processes to finish
wait
