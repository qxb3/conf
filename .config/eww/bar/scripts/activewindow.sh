#!/bin/sh

function active_window() {
  active_window=`hyprctl activewindow -j`
  class=`echo "${active_window}" | jq -r '.initialClass'`
  title=`echo "${active_window}" | jq -r '.title'`

  active_workspace=`hyprctl monitors -j | jq '.[0].activeWorkspace.name'`
  icon=""
  if [[ $active_workspace == '"1"' ]]; then icon=""; fi
  if [[ $active_workspace == '"2"' ]]; then icon="󰈹"; fi
  if [[ $active_workspace == '"3"' ]]; then icon="󰙯"; fi
  if [[ $active_workspace == '"4"' ]]; then icon=""; fi
  if [[ $active_workspace == '"5"' ]]; then icon=""; fi

  if [[ $class != "null" ]]; then
    ICON='"icon": "%s"'
    CLASS='"class": "%s"'
    TITLE='"title": "%s"'

    printf "{${ICON}, ${CLASS}, ${TITLE}}\n" "$icon" "$class" "$title"
  else
    ICON='"icon": "%s"'
    CLASS='"class": "~"'
    TITLE='"title": "~"'

    printf "{${ICON}, ${CLASS}, ${TITLE}}\n" "$icon"
  fi
}

active_window "activewindow"
socat - "UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock" | while read -r line; do active_window "$line"; done
