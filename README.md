# Linux Server Setup & User Management Automation

Bash project for automating Linux server setup, user/group management, SSH, firewall, permissions, backups and reporting.

## Features
- Server information report
- Package installation
- User/group management
- User lock/unlock/delete
- Wheel/sudo configuration
- Shared directories and permissions
- SSH service setup
- Firewalld SSH rule
- User audit
- Configuration backup
- Logging
- Interactive menu

## Supported
Primarily CentOS Stream / RHEL / Rocky Linux / AlmaLinux using `dnf` (falls back to `yum`).

## Quick Start
```bash
git clone https://github.com/YOUR_USERNAME/linux-server-setup-user-management.git
cd linux-server-setup-user-management
chmod +x scripts/*.sh
sudo ./scripts/server_setup.sh
sudo ./scripts/user_management.sh
sudo ./scripts/backup.sh
sudo ./scripts/server_info.sh
```

## Security
Do not commit passwords, private keys, tokens, `/etc/shadow`, or production secrets. Test on a lab VM first.

## Suggested GitHub topics
`linux` `bash` `shell-scripting` `linux-administration` `system-administration` `devops` `automation` `centos` `rhel`
