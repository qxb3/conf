#!/usr/bin/env bash

set -e

IMG=$(mktemp --suffix=.png)
trap 'rm -f "$IMG"' EXIT

grim -g "$(slurp)" "$IMG"

TEXT=$(tesseract "$IMG" stdout 2>/dev/null | sed '/^$/d')

if [ -z "$TEXT" ]; then
    notify-send "OCR" "No text detected."
    exit 1
fi

printf "%s" "$TEXT" | wl-copy
