#!/bin/bash

USERNAME="aemonge"
USER_HOME="/home/$USERNAME"
LOCAL_SYS_DIR="$USER_HOME/os/"

# Ensure running as root
if [[ $(id -u) -ne 0 ]]; then
    echo "This script must be run as root"
    exit 1
fi

# 1. List all files under LOCAL_SYS_DIR
find "$LOCAL_SYS_DIR" -type f | while read -r local_file; do
    # Extract the path after the LOCAL_SYS_DIR
    relative_path="${local_file#$LOCAL_SYS_DIR}"
    # Determine the corresponding system file path
    system_file="/$relative_path"

    # Check if the system file exists
    if [[ -f $system_file ]]; then
        # Compare file modification times
        local_mtime=$(stat -c %Y "$local_file")
        system_mtime=$(stat -c %Y "$system_file")

        if [[ $local_mtime -gt $system_mtime ]]; then
            RECENT="$local_file"
            OLDER="$system_file"
        else
            RECENT="$system_file"
            OLDER="$local_file"
        fi

        # Perform the rsync from $RECENT to $OLDER to update the older based on the most recent
        # BUG: Unsure about this --no-o --no-g --no-p \
        /usr/bin/rsync -a --delete --exclude 'lost+found' \
            --no-o --no-g --no-p \
            "$RECENT" "$(dirname "$OLDER")"
    else
        # The system file does not exist, so create it with root permissions
        echo "System file $system_file does not exist. Creating it."
        # Ensure the directory exists
        mkdir -p "$(dirname "$system_file")"
        # Copy the file
        cp "$local_file" "$system_file"
        # Optionally, set permissions explicitly. Since the script runs as root, files will be owned by root by default.
        # chown root:root "$system_file"
        # chmod <desired-permissions> "$system_file"
    fi
done

# BUG: Sometimes the owner of the system file is not the same as the owner of the local file.
find $USER_HOME -user root -exec chown $USERNAME:$USERNAME {} \;
