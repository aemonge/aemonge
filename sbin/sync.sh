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
    echo "(root): rsync $LOCAL_SYS_DIR to /"
    rsync -av --delete --exclude 'lost+found' --ignore-errors \
          --files-from=<(find $LOCAL_SYS_DIR -mindepth 1 -type f | sed "s#^$USER_HOME/os/##") \
          $LOCAL_SYS_DIR /
}

cleanup() {
    # Function to clean up background processes and unmount pCloud directory
    echo "Cleaning up: Un-mounting and killing `inotifywait` processes."
    pkill -P $$
    fusermount -u "$MOUNT_POINT" || umount "$MOUNT_POINT"
}
trap cleanup SIGTERM SIGINT EXIT

# Sync local system configurations first
for SRC in "${!CLOUD_DIRS[@]}"; do
    echo "$USERNAME:" rclone bisync pcloud:${CLOUD_DIRS[$SRC]} "$SRC"
    sudo -u $USERNAME -- rclone bisync pcloud:${CLOUD_DIRS[$SRC]} "$SRC" \
    | sudo -u $USERNAME -- rclone bisync pcloud:${CLOUD_DIRS[$SRC]} "$SRC" --resync

    while inotifywait -r -e modify,create,delete,move "$SRC"; do
        sudo -u $USERNAME -- rclone bisync pcloud:${CLOUD_DIRS[$SRC]} "$SRC"
    done &
done

# Monitor the local system directory for changes
sync_local_sys
while inotifywait -r -e modify,create,delete,move "$LOCAL_SYS_DIR"; do
    sync_local_sys
done &

# Mount pCloud directory
MOUNT_POINT="$USER_HOME/cloud"
sudo -u $USERNAME -- mkdir -p "$MOUNT_POINT"
sudo -u $USERNAME -- rclone mount pcloud:/ "$MOUNT_POINT" \
    --daemon --vfs-cache-mode full

# Wait for all background processes to finish
wait
