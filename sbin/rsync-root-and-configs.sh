#!/bin/bash

USERNAME="aemonge"
USER_HOME="/home/$USERNAME"
LOCAL_SYS_DIR="$USER_HOME/os/"

# 1. List all files under LOCAL_SYS_DIR
# 2. Check for last modify date between the local_sys file and the actual sys file
# 3. Assign $RECENT $OLDER variables depending on the file check
for local_file in $(find $LOCAL_SYS_DIR -type f); do
    # Extract the path after the LOCAL_SYS_DIR
    relative_path=${local_file#$LOCAL_SYS_DIR}
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

        # 4. Perform the rsync from $RECENT to $OLDER to update the older based on the most recent
        rsync -a --delete --exclude 'lost+found' \
            --no-o --no-g --no-p \
            $RECENT $OLDER
    else
        echo "System file $system_file does not exist. No rsync needed."
    fi
done
