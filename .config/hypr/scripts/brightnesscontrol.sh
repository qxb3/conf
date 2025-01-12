#!/usr/bin/env sh

function print_error() {
cat << "EOF"
    ./brightnesscontrol.sh <action>
    ...valid actions are...
        i -- <i>ncrease brightness [+5%]
        d -- <d>ecrease brightness [-5%]
EOF
}

case $1 in
  i) brightnessctl set +5% ;;
  d) brightnessctl set 5%- ;;
  *) print_error ;;
esac

