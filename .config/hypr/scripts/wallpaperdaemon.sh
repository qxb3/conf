#!/bin/bash

swww query
if [ $? -eq 1 ]; then
  swww-daemon --format xrgb &
fi
