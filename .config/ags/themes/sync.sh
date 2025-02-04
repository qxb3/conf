#!/bin/bash

# sync.sh
# Sync ricable things to the current theme

theme=$1

if [ -z $theme ]; then
  echo "Theme is required"
  echo '$ sync.sh <theme>'

  exit 1
fi

WALLPAPERS_PATH="$HOME/.config/swww"
AGS_PATH="$HOME/.config/ags"
KITTY_PATH="$HOME/.config/kitty"
NVIM_PATH="$HOME/.config/nvim"
LOCAL_STATE="$HOME/.local/state/retro"

sync_ags() {
  theme=$1
  if [ -z $theme ]; then
    echo 'sync_ags <theme> is required'
    exit 1
  fi

  ln -sf "$AGS_PATH/themes/$theme.scss" "$LOCAL_STATE/ags_theme.scss"
}

sync_wallpapers() {
  theme=$1
  if [ -z $theme ]; then
    echo 'sync_wallpapers <theme> is required'
    exit 1
  fi

  current_wall="$LOCAL_STATE/wallpapers"

  rm -rf $current_wall
  ln -sf "$WALLPAPERS_PATH/$theme" "$LOCAL_STATE/wallpapers"
  ln -sf "$WALLPAPERS_PATH/$theme/default.png" "$LOCAL_STATE/current_wallpaper"

  random_x=$(echo "scale=2; $RANDOM/32767" | bc)
  random_y=$(echo "scale=2; $RANDOM/32767" | bc)

  swww img "$LOCAL_STATE/current_wallpaper" \
    --transition-type "grow" \
    --transition-pos $random_x,$random_y \
    --transition-duration 3
}

sync_no_music() {
  theme=$1
  if [ -z $theme ]; then
    echo 'sync_no_music <theme> is required'
    exit 1
  fi

  ln -sf "$AGS_PATH/assets/images/$theme.no_music.png" "$LOCAL_STATE/no_music"
}

sync_kitty() {
  theme=$1
  if [ -z $theme ]; then
    echo 'sync_kitty <theme> is required'
    exit 1
  fi

  ln -sf "$KITTY_PATH/themes/$theme.conf" "$LOCAL_STATE/kitty_theme.conf"
  killall -USR1 kitty
}

sync_nvim() {
  theme=$1
  if [ -z $theme ]; then
    echo 'sync_nvim <theme> is required'
    exit 1
  fi

  ln -sf "$NVIM_PATH/lua/core/themes/$theme.lua" "$LOCAL_STATE/nvim_theme.lua"
  nvim \
    --server /tmp/nvim \
    --remote-send ":source $LOCAL_STATE/nvim_theme.lua<CR>"
}

sync_ags $theme
sync_wallpapers $theme
sync_no_music $theme
sync_kitty $theme
sync_nvim $theme

# Change the theme name
echo $theme > "$LOCAL_STATE/theme_name"
