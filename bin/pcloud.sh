#!/bin/bash

USERNAME="aemonge"
USER_HOME="/home/$USERNAME"
MOUNT_POINT="$USER_HOME/cloud"

# Mount pCloud directory
echo "Mounting pCloud directory"
rclone mount pcloud:/ $MOUNT_POINT --daemon --vfs-cache-mode full

# Function for cleanup
cleanup() {
    echo "Cleaning up: Un-mounting pCloud directory."
    fusermount -u "$MOUNT_POINT" || umount "$MOUNT_POINT"
}

# Set trap for cleanup on script exit, SIGINT, or SIGTERM
trap cleanup SIGTERM SIGINT EXIT
