#!/bin/bash
# login-auditor.sh
# Produces a concise, repeatable summary of recent logins and failed SSH attempts.
# Output is appended to /tmp/login-auditor.log for manual review.

LOG="/tmp/login-auditor.log"
printf "=== Login audit — %s ===\n" "$(date)" >> "$LOG"

echo "Last 10 successful logins:" >> "$LOG"
last -a -n 10 >> "$LOG" 2>/dev/null

echo -e "\nFailed SSH attempts (past hour):" >> "$LOG"
journalctl _COMM=sshd --since "1 hour ago" 2>/dev/null | grep -i "fail\|invalid" >> "$LOG" || echo "none recorded" >> "$LOG"

echo "----------------------------------------" >> "$LOG"
