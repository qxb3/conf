#!/bin/bash

swww query
if [ $? -eq 1 ]; then
  random_x=$(echo "scale=2; $RANDOM/32767" | bc)
  random_y=$(echo "scale=2; $RANDOM/32767" | bc)

  swww-daemon --format xrgb &

  swww img ~/.local/state/retro/current_wallpaper \
    --transition-type "grow" \
    --transition-pos $random_x,$random_y \
    --transition-duration 3
fi
