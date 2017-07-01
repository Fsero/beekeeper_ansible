#!/usr/bin/env bash
set -euo pipefail

FREE_SPACE_THRESHOLD=10
MOUNT_TO_WATCH="/"
TRACES_DIR="/var/log/traces"
LAST_MODIFIED_FILES_TO_KEEP_IN_MINUTES="60"


get_free_disk_left() {
    percent=$(df -h ${MOUNT_TO_WATCH} --output=pcent | tail -1 | xargs | tr -d '%')
    FREE_SPACE=$((100-percent))
}

check_if_cleanup_is_needed () {
    if [[ $FREE_SPACE -le $FREE_SPACE_THRESHOLD ]]; then
        logger -t info "[cleanup] removing old traces"
        find $TRACES_DIR  -path "/var/log/traces/.ssh/*" -prune -o -xtype f -mmin +$LAST_MODIFIED_FILES_TO_KEEP_IN_MINUTES -print0 | xargs -0 -L 50 rm
    fi
}

get_free_disk_left
check_if_cleanup_is_needed