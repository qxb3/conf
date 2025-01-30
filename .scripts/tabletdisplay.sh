hyprctl output create headless TabletDisplay
nohup wayvnc 0.0.0.0 5900 --output TabletDisplay --gpu --max-fps 120 -Ldebug &> /dev/null &
