# Useful Commands

## Users
```bash
useradd -m username
passwd username
id username
userdel -r username
passwd -l username
passwd -u username
chage -l username
```

## Groups
```bash
groupadd developers
getent group developers
usermod -aG developers username
```

## Permissions
```bash
chown root:developers /opt/company/development
chmod 2775 /opt/company/development
```

## Services
```bash
systemctl status sshd
systemctl enable --now sshd
systemctl restart sshd
```

## Firewall
```bash
firewall-cmd --permanent --add-service=ssh
firewall-cmd --reload
firewall-cmd --list-services
```

## Monitoring
```bash
hostname
uptime
free -h
df -h
ip addr
ss -tulnp
```

## Audit
```bash
awk -F: '$3 >= 1000 {print $1}' /etc/passwd
who
w
```
