#!/bin/bash

function close_special_workspace() {
  special_open=`hyprctl monitors -j | jq ".[0].specialWorkspace.name" | grep "special"`
  if [ ! -z $special_open ]; then
    hyprctl dispatch togglespecialworkspace
  fi
}

function close_file_explorer() {
  ags request file_explorer:close
}

widget_control() {
  while read -r line; do
    echo "${line:0:9}"

    # Changes workspace
    if [ ${line:0:9} == "workspace" ]; then
      close_special_workspace
      close_file_explorer
    fi

    if [ ${line:0:18} == "changefloatingmode" ] && [ ${line:33:34} == "1" ]; then
      close_file_explorer
    fi

    # Opens up special workspace
    if [ ${line:0:22} == "activespecial>>special" ]; then
      close_file_explorer
    fi
  done
}

socat -u "UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock" - | widget_control
