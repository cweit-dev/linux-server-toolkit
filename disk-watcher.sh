#!/bin/bash
# Disk space watchdog – alerts when any partition > 85%
THRESHOLD=85
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/pushover.sh"

ALERT_SENT=false

df -P | tail -n +2 | while read -r DEV TOTAL USED AVAIL USE MOUNT; do
  # Extract percentage without the % sign
  USE_PERCENT=$(echo "$USE" | tr -d '%')
  
  if (( USE_PERCENT > THRESHOLD )); then
    MESSAGE="Disk Alert: $MOUNT ($DEV) at ${USE_PERCENT}%"
    echo "[$(date)] WARNING: $MESSAGE"
    pushover "Disk Alert" "$MESSAGE"
    ALERT_SENT=true
  fi
done

$ALERT_SENT || echo "[$(date)] All disks below ${THRESHOLD}% – looking good"
