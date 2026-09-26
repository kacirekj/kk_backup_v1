#!/bin/bash

# It fully extracts all TARs from the configured path.
#
# Usage:
#   kk_backup_tar_restore.sh
#   kk_backup_tar_restore.sh PATH...
#
# Arguments:
#   PATH...     Optional files to be extracted from all TARs.
#
# Examples:
#   kk_backup_tar_restore.sh home/debian root etc
#
# Warning:
#   Do not use initial "/" when specifying the file paths!

mkdir output

for TAR_FILE in /Volumes/mac_backup/tar_backup/backup_*.tar; do
    tar --extract --verbose --listed-incremental=/dev/null \
        --file="$TAR_FILE" --directory=output "$@"
done

echo "Finished"
