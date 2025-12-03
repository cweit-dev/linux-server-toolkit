#!/bin/bash
# safe-upgrade.sh
# Non-interactive update/upgrade with controlled reboot.
# Reboots only when a kernel package is installed.

LOG="/var/log/safe-upgrade.log"
echo "=== safe-upgrade started $(date) ===" | tee -a "$LOG"

apt update && apt upgrade -y >> "$LOG" 2>&1

if grep -qi "linux-image" "$LOG"; then
    echo "Kernel package updated — scheduling reboot in 5 minutes" | tee -a "$LOG"
    shutdown -r +5 "Automated reboot after kernel update (safe-upgrade.sh)"
else
    echo "Upgrade completed — no kernel changes, staying online" | tee -a "$LOG"
fi
