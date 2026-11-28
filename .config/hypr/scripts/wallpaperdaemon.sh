#!/bin/bash

awww query
if [ $? -eq 1 ]; then
  awww-daemon --format xrgb
fi
