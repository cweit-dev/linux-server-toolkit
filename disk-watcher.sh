#!/bin/bash
THRESHOLD=85
LOGFILE="/tmp/disk-watcher.log"

echo "=== Disk check $(date) ===" >> "$LOGFILE"

ALERT=false
df -P | tail -n +2 | while read -r DEV TOTAL USED AVAIL USE MOUNT; do
  USE_PERCENT=${USE%?}
  if (( USE_PERCENT > THRESHOLD )); then
    echo "ALERT: $MOUNT ($DEV) at ${USE_PERCENT}%" | tee -a "$LOGFILE"
    ALERT=true
  fi
done

$ALERT || echo "All good – everything below ${THRESHOLD}%" | tee -a "$LOGFILE"
echo "----------------------------------" >> "$LOGFILE"
