#!/bin/bash

floating=$(hyprctl activewindow -j | jq '.floating')
window=$(hyprctl activewindow -j | jq '.initialClass' | tr -d "\"")

# Hyprland >= 0.55: `hyprctl dispatch` takes Lua (hl.dsp.*), and the Lua resize dispatcher
# only accepts pixels. The old `resizeactive exact 45% 50%` percentages are therefore
# resolved here against the focused monitor's logical size.
function monitor_size() {
  hyprctl monitors -j | jq -r '.[] | select(.focused) |
    (if (.transform % 2) == 1 then [.height, .width] else [.width, .height] end) as $s |
    "\(($s[0] / .scale) | floor) \(($s[1] / .scale) | floor)"'
}

function toggle() {
  width=${1%\%}
  height=${2%\%}

  read -r mon_w mon_h <<< "$(monitor_size)"
  px_w=$(( mon_w * width / 100 ))
  px_h=$(( mon_h * height / 100 ))

  hyprctl --batch "dispatch hl.dsp.window.float({ action = 'toggle' }); dispatch hl.dsp.window.resize({ x = ${px_w}, y = ${px_h}, relative = false }); dispatch hl.dsp.window.center()"
}

function untoggle() {
  hyprctl dispatch "hl.dsp.window.float({ action = 'toggle' })"
}

function handle() {
  width=$1
  height=$2

  if [ $floating == "false" ]; then
    toggle $width $height
  else
    untoggle
  fi
}

case $window in
  kitty) handle "45%" "50%" ;;
  *) handle "75%" "80%" ;;
esac
