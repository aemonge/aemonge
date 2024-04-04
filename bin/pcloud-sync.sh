#!/bin/bash

USERNAME="aemonge"
USER_HOME="/home/$USERNAME"

# Define directories to sync
declare -A CLOUD_DIRS=(
    ["/os"]="$USER_HOME/os"
    ["/settings"]="$USER_HOME/settings"
    ["/media/images"]="$USER_HOME/images"
    ["/documents/dev"]="$USER_HOME/documents"
    ["/public"]="$USER_HOME/public"
    ["/stash"]="$USER_HOME/stash"
    ["/documents/studies/UNED"]="$USER_HOME/studies"
)

# Perform initial sync for each directory
for REMOTE_DIR in "${!CLOUD_DIRS[@]}"; do
    LOCAL_DIR=${CLOUD_DIRS[$REMOTE_DIR]}
    echo "Syncing $REMOTE_DIR to $LOCAL_DIR"
    rclone bisync --checksum "pcloud:$REMOTE_DIR" "$LOCAL_DIR" ||
        rclone bisync -v --resync --checksum "pcloud:$REMOTE_DIR" "$LOCAL_DIR"

done

# Wait for all background processes to finish
wait
