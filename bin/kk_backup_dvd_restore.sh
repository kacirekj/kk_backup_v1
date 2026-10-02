#!/bin/bash
set -euo pipefail

# It re-construct original files which has been processed by
# the kk_backup_dvd_prepare.sh.
#
# Usage:
#   kk_backup_dvd_restore.sh PREFIX
#
# Arguments:
#   PREFIX      Common prefix of the kk_backup_dvd_prepare.sh output files
#
# Examples:
#   kk_backup_dvd_restore.sh backup.tar.ossl_aes_256_cbc.split_
#
# Warning:
#   Be precise with the provided prefix!

par2 repair "${1}"xxxx

mkdir "kk_output_dvd"

cat "${1}"???? \
    | openssl enc -d -aes-256-cbc \
    | tar -xzf - --directory="kk_output_dvd"
