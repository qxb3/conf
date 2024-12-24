#!/bin/bash

color=$(hyprpicker)

echo "$color" | wl-copy

notify-send \
  -a "Color Picker" \
  "Copied to clipboard" \
  "Color: $color"
