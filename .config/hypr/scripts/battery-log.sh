#!/bin/bash

CACHE_DIR="$HOME/.cache/ags"
BATTERY_FILE="$CACHE_DIR/battery.json"

rm "$BATTERY_FILE"

mkdir -p "$CACHE_DIR"
if [[ ! -f "$BATTERY_FILE" ]]; then
  echo "[]" > "$BATTERY_FILE"
fi

while true; do
  BATTERY_CAPACITY=$(cat /sys/class/power_supply/BAT0/capacity 2>/dev/null || echo "Battery info not available")

  TIMESTAMP=$(date +%s)

  EXISTING_CONTENT=$(cat "$BATTERY_FILE")

  NEW_LOG="{\"timestamp\": $TIMESTAMP, \"battery_level\": \"$BATTERY_CAPACITY\"}"
  UPDATED_CONTENT=$(echo "$EXISTING_CONTENT" | jq -c ". + [$NEW_LOG]")

  echo "$UPDATED_CONTENT" > "$BATTERY_FILE"

  sleep 1800
done
