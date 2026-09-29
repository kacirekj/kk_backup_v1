#!/bin/bash

# It creates initial or incremental TAR backup into configured target directory.
#
# Usage:
#   kk_backup_tar_create.sh
#
# No parameters needed.

# Validate

if [[ -f "/mnt/debian_backup/tar_backup/backup_$(date +%Y_%m_%d_T_%H_%M).tar" ]]; then
    echo "Backup file already exists. Wait for a while."
    exit 1
fi

# Create backup

tar -cv \
    -g "/mnt/debian_backup/tar_backup/backup.snar" \
    -f "/mnt/debian_backup/tar_backup/backup_$(date +%Y_%m_%d_T_%H_%M).tar" \
    --exclude='./home/debian/.local/share/Trash/*' \
    --exclude='./home/debian/Desktop/*' \
    --exclude='./home/debian/Videos/*' \
    --exclude='./home/debian/Downloads/*' \
    --exclude='./home/debian/tmp/*' \
    --exclude='./root/tmp/*' \
    -C / \
    ./home/debian \
    ./mnt/debian_backup/tar_backup/backup.snar \
    ./root

# Backup current snar

cp  "/mnt/debian_backup/tar_backup/backup.snar" \
    "/mnt/debian_backup/tar_backup/backup_$(date +%Y_%m_%d_T_%H_%M).snar"
