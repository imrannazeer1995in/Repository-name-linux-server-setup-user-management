#!/bin/bash
set -u
echo '========================================'
echo ' Linux Server Information'
echo '========================================'
echo; echo 'Hostname:'; hostname
echo; echo 'Operating System:'; [ -f /etc/os-release ] && . /etc/os-release && echo "$PRETTY_NAME"
echo; echo 'Kernel:'; uname -r
echo; echo 'Uptime:'; uptime -p 2>/dev/null || uptime
echo; echo 'IP Addresses:'; hostname -I 2>/dev/null || true
echo; echo 'Memory:'; free -h
echo; echo 'Disk Usage:'; df -h
echo; echo 'Current User:'; whoami
echo; echo 'Date:'; date
