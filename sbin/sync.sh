#!/bin/bash

# Variables
USERNAME="aemonge"
USER_HOME="/home/$USERNAME"
REMOTE="pcloud"
declare -A CLOUD_DIRS
CLOUD_DIRS["$USER_HOME/os"]="/os"
CLOUD_DIRS["$USER_HOME/settings"]="/settings"
CLOUD_DIRS["$USER_HOME/images"]="/media/images"
CLOUD_DIRS["$USER_HOME/documents"]="/documents/dev"
CLOUD_DIRS["$USER_HOME/public"]="/public"
CLOUD_DIRS["$USER_HOME/stash"]="/stash"
CLOUD_DIRS["$USER_HOME/studies"]="/documents/studies/UNED"

LOCAL_SYS_DIR="$USER_HOME/os/"

sync_local_sys() {
    # Function to sync local system configurations
    echo "rsync $LOCAL_SYS_DIR to /"
    rsync -av --delete --exclude 'lost+found' \
          --files-from=<(find $LOCAL_SYS_DIR -mindepth 1 -type f | sed "s#^$USER_HOME/os/##") \
          $LOCAL_SYS_DIR /
}

sync_to_pcloud() {
    # Function to run rclone sync
    echo "bidirectional rclone with src:$src dest:$REMOTE:$dest"
    local src=$1
    local dest=$2

    sudo -u $USERNAME -- rclone sync "$src" "$REMOTE:$dest" --update --config "$USER_HOME/.config/rclone/rclone.conf"
    sudo -u $USERNAME -- rclone sync "$REMOTE:$dest" "$src" --update --config "$USER_HOME/.config/rclone/rclone.conf"
}

cleanup() {
    # Function to clean up background processes and unmount pCloud directory
    echo "Cleaning up: Un-mounting and killing `inotifywait` processes."
    pkill -P $$
    fusermount -u "$MOUNT_POINT" || umount "$MOUNT_POINT"
}

trap cleanup SIGTERM SIGINT EXIT

# Sync local system configurations first
sync_local_sys
for SRC in "${!CLOUD_DIRS[@]}"; do
    while inotifywait -r -e modify,create,delete,move "$SRC"; do
        sync_to_pcloud "$SRC" "${CLOUD_DIRS[$SRC]}"
    done &
done

# Monitor the local system directory for changes
while inotifywait -r -e modify,create,delete,move "$LOCAL_SYS_DIR"; do
    sync_local_sys
done &

# Mount pCloud directory
MOUNT_POINT="$USER_HOME/cloud"
mkdir -p "$MOUNT_POINT"
chown "$USERNAME:$USERNAME" "$MOUNT_POINT"
sudo -u $USERNAME -- rclone mount pcloud:/ "$MOUNT_POINT" --daemon --vfs-cache-mode full --config "$USER_HOME/.config/rclone/rclone.conf"

# Wait for all background processes to finish
wait
