#!/bin/bash
# Disk space watchdog – sends email when any partition > 85%
THRESHOLD=85
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
[ -f "$SCRIPT_DIR/config" ] && source "$SCRIPT_DIR/config"

# Default email if not set in config
EMAIL="${EMAIL:-your-email@gmail.com}"

ALERT_SENT=false

df -P | tail -n +2 | while read -r DEV TOTAL USED AVAIL USE MOUNT; do
  USE_PERCENT=$(echo "$USE" | tr -d '%')
  
  if (( USE_PERCENT > THRESHOLD )); then
    SUBJECT="Disk Alert – $(hostname) – $MOUNT at ${USE_PERCENT}%"
    MESSAGE="Warning: $MOUNT ($DEV) is at ${USE_PERCENT}% capacity\n\n$(df -h)\n\nRun: du -sh /* | sort -h  to investigate"
    
    echo -e "$MESSAGE" | mail -s "$SUBJECT" "$EMAIL"
    echo "[$(date)] ALERT SENT: $SUBJECT to $EMAIL"
    ALERT_SENT=true
  fi
done

$ALERT_SENT || echo "[$(date)] All disks below ${THRESHOLD}% – OK"
