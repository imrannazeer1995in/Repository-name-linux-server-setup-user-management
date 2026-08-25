#!/bin/bash
set -euo pipefail
LOGFILE=/var/log/user_management.log
log(){ echo "$(date '+%F %T') - $*" | tee -a "$LOGFILE"; }
[ "$EUID" -eq 0 ] || { echo 'ERROR: Run as root or with sudo.'; exit 1; }
touch "$LOGFILE"; chmod 600 "$LOGFILE"
valid_username(){ [[ "$1" =~ ^[a-z_][a-z0-9_-]{0,31}$ ]]; }
while true; do
 echo; echo '================================'; echo ' User Management Menu'; echo '================================'
 echo '1. Create User'; echo '2. Delete User'; echo '3. Lock User'; echo '4. Unlock User'; echo '5. Show User'; echo '6. List Users'; echo '7. Create Group'; echo '8. Add User to Group'; echo '9. Exit'
 read -rp 'Enter choice: ' choice
 case "$choice" in
 1) read -rp 'Enter username: ' u; valid_username "$u" || { echo 'Invalid username.'; continue; }; id "$u" >/dev/null 2>&1 && { echo 'User already exists.'; continue; }; useradd -m -s /bin/bash "$u"; passwd "$u"; log "Created user: $u" ;;
 2) read -rp 'Enter username: ' u; [ "$u" != root ] || { echo 'Refusing to delete root.'; continue; }; id "$u" >/dev/null 2>&1 || { echo 'User does not exist.'; continue; }; userdel -r "$u"; log "Deleted user: $u" ;;
 3) read -rp 'Enter username: ' u; passwd -l "$u"; log "Locked user: $u" ;;
 4) read -rp 'Enter username: ' u; passwd -u "$u"; log "Unlocked user: $u" ;;
 5) read -rp 'Enter username: ' u; id "$u" && chage -l "$u" 2>/dev/null || true ;;
 6) awk -F: '$3 >= 1000 && $3 < 65534 {printf "%-20s UID=%-6s HOME=%s\n", $1, $3, $6}' /etc/passwd ;;
 7) read -rp 'Enter group name: ' g; getent group "$g" >/dev/null || { groupadd "$g"; log "Created group: $g"; } ;;
 8) read -rp 'Enter username: ' u; read -rp 'Enter group: ' g; id "$u" >/dev/null 2>&1 || { echo 'User does not exist.'; continue; }; getent group "$g" >/dev/null || { echo 'Group does not exist.'; continue; }; usermod -aG "$g" "$u"; log "Added $u to group $g" ;;
 9) exit 0 ;;
 *) echo 'Invalid choice.' ;;
 esac
done
