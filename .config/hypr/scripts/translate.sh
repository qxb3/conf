#!/usr/bin/env bash

set -e

img=$(mktemp --suffix=.png)
trap 'rm -f "$img"' exit

grim -g "$(slurp)" "$img"

text=$(tesseract "$img" stdout 2>/dev/null | sed '/^$/d')

[ -z "$text" ] && {
    notify-send "translate" "no text detected."
    exit 1
}

translation=$(printf "%s" "$text" | trans -brief :en)

printf "%s" "$translation" | wl-copy

printf "%s" "$translation" | \
wofi --dmenu \
      --prompt "translated (copied to clipboard)" \
      --width 700 \
      --height 300

