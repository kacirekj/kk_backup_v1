#!/bin/bash

# It creates initial or incremental TAR backup into configured target directory.
#
# Usage:
#   kk_backup_tar_create.sh
#
# No parameters needed.

# Validate

if [[ -f "/Volumes/mac_backup/tar_backup/backup_$(date +%Y_%m_%d_T_%H_%M).tar" ]]; then
    echo "Backup file already exists. Wait for a while."
    exit 1
fi

# Create backup

tar --create --verbose \
    --listed-incremental="/Volumes/mac_backup/tar_backup/backup.snar" \
    --file="/Volumes/mac_backup/tar_backup/backup_$(date +%Y_%m_%d_T_%H_%M).tar" \
    --exclude='/Users/jiri/.config/xnviewmp/Thumb.db' \
    --exclude='/Users/jiri/.config/xnviewmp/XnView.db' \
    --exclude='/Users/jiri/Pictures/Photo*' \
    /Users/jiri/.bash_history \
    /Users/jiri/.bash_profile \
    /Users/jiri/.config/xnviewmp \
    /Users/jiri/.ssh \
    /Users/jiri/Documents \
    /Users/jiri/Pictures \
    /Users/jiri/kk_mac_config \
    /Users/jiri/projekty \
    /Volumes/mac_backup/tar_backup/*.snar

# Backup current snar

cp "/Volumes/mac_backup/tar_backup/backup.snar" \
    "/Volumes/mac_backup/tar_backup/backup_$(date +%Y_%m_%d_T_%H_%M).snar"
