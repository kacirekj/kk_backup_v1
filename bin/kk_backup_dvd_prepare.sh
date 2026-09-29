#!/bin/bash
set -euo pipefail

# It creates files suitable to be burned on optical discs.
#
# Usage:
#   kk_backup_dvd_prepare.sh PATH...
#
# Arguments:
#   PATH...    Files or directories to be included in result.
#
# Examples:
#   kk_backup_dvd_prepare.sh /home/debian /root /etc

TIMESTAMP="$(date +%Y_%m_%d_T_%H_%M)"

tar --create -v --gzip -f - "$@" \
    | openssl enc -aes-256-cbc \
    | split -d -a 4 -b 46500000 - "dvd_backup_${TIMESTAMP}.tar.gz.ossl-aes-256-cbc.split_"

par2 create -r20 -n30 -u \
    "dvd_backup_${TIMESTAMP}.tar.gz.ossl-aes-256-cbc.split_xxxx" \
    "dvd_backup_${TIMESTAMP}.tar.gz.ossl-aes-256-cbc.split_"*
