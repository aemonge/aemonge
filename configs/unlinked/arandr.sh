#!/bin/sh

sleep 2s;

xrandr --output eDP --mode 800x1280 --pos 1376x1210 --rotate right --scale 0.6 \
  --output DisplayPort-0 --off \
  --output DisplayPort-1 --off \
  --output DisplayPort-2 --primary --mode 1920x1080 --pos 1080x130 --rotate normal \
  --output DisplayPort-3 --mode 1920x1080 --pos 0x0 --rotate left
