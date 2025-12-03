#!/bin/bash
# Helper: sends Pushover notification (free tier works forever)
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
[ -f "$SCRIPT_DIR/config" ] && source "$SCRIPT_DIR/config"

if [[ -n "$PUSHOVER_TOKEN" && -n "$PUSHOVER_USER" ]]; then
  curl -s \
    --form-string "token=$PUSHOVER_TOKEN" \
    --form-string "user=$PUSHOVER_USER" \
    --form-string "title=$1" \
    --form-string "message=$2" \
    https://api.pushover.net/1/messages.json > /dev/null 2>&1
fi
