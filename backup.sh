#!/bin/bash
set -euo pipefail
[ "$EUID" -eq 0 ] || { echo 'ERROR: Run as root or with sudo.'; exit 1; }
BACKUP_DIR=/backup/linux-server
DATE=$(date '+%Y-%m-%d_%H-%M-%S')
mkdir -p "$BACKUP_DIR"
tar -czf "$BACKUP_DIR/server_config_$DATE.tar.gz" /etc/passwd /etc/group /etc/shadow /etc/ssh/sshd_config /etc/hosts
chmod 600 "$BACKUP_DIR/server_config_$DATE.tar.gz"
echo "Backup created: $BACKUP_DIR/server_config_$DATE.tar.gz"
