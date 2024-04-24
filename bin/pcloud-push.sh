#!/bin/bash

USERNAME="aemonge"
USER_HOME="/home/$USERNAME"

# Define directories to sync
declare -A CLOUD_DIRS=(
    ["/os"]="$USER_HOME/os"
    ["/settings"]="$USER_HOME/settings"
    ["/media/images"]="$USER_HOME/images"
    ["/media/videos"]="$USER_HOME/videos"
    ["/media/music"]="$USER_HOME/music"
    ["/documents/dev"]="$USER_HOME/documents"
    ["/public"]="$USER_HOME/public"
    ["/stash"]="$USER_HOME/stash"
    ["/documents/studies/UNED"]="$USER_HOME/studies"
)

# Array to store PIDs of background processes
PIDS=()

# Trap function to handle cleanup
trap 'cleanup' INT TERM EXIT

cleanup() {
    # Kill all background processes
    for pid in "${PIDS[@]}"; do
        kill "$pid" 2>/dev/null
    done
    wait 2>/dev/null
    echo "Cleanup completed."
}

# Sync before
echo "Syncing before..."
sudo ~/profile/sbin/pcloud-root-sync.sh || exit 1

# Perform initial sync for each directory in parallel
for REMOTE_DIR in "${!CLOUD_DIRS[@]}"; do
    LOCAL_DIR=${CLOUD_DIRS[$REMOTE_DIR]}
    echo "Syncing $REMOTE_DIR to $LOCAL_DIR"
    rclone sync --check-first -P "$LOCAL_DIR" "pcloud:$REMOTE_DIR" &
    PIDS+=($!)
done

# Wait for all background processes to finish
wait

echo "Sync completed."
