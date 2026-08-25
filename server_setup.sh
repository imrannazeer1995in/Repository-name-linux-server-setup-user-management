#!/bin/bash
set -euo pipefail
LOGFILE=/var/log/server_setup.log
log(){ echo "$(date '+%F %T') - $*" | tee -a "$LOGFILE"; }
[ "$EUID" -eq 0 ] || { echo 'ERROR: Run as root or with sudo.'; exit 1; }
touch "$LOGFILE"; chmod 600 "$LOGFILE"
if command -v dnf >/dev/null 2>&1; then PKG=dnf; elif command -v yum >/dev/null 2>&1; then PKG=yum; else echo 'ERROR: dnf/yum not found.'; exit 1; fi
log 'Starting Linux server setup.'
$PKG install -y vim wget curl git net-tools tar
getent group developers >/dev/null || groupadd developers
getent group support >/dev/null || groupadd support
mkdir -p /opt/company/development /opt/company/support
chown root:developers /opt/company/development; chown root:support /opt/company/support
chmod 2775 /opt/company/development /opt/company/support
if systemctl list-unit-files | grep -q '^sshd.service'; then systemctl enable --now sshd; elif systemctl list-unit-files | grep -q '^ssh.service'; then systemctl enable --now ssh; fi
if command -v firewall-cmd >/dev/null 2>&1; then systemctl enable --now firewalld; firewall-cmd --permanent --add-service=ssh; firewall-cmd --reload; fi
mkdir -p /backup/server_setup
cp -a /etc/passwd /backup/server_setup/passwd.bak
cp -a /etc/group /backup/server_setup/group.bak
cp -a /etc/shadow /backup/server_setup/shadow.bak
chmod 600 /backup/server_setup/shadow.bak
log 'Server setup completed successfully.'
