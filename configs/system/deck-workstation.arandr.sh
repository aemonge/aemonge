#!/bin/sh

CONNECTED_MONITORS="$(xrandr --listmonitors | head -1 | cut -f2 -d' ')"

if [ "$CONNECTED_MONITORS" -eq 3 ] ; then
    sleep 1.5s;
    xrandr --output eDP --mode 800x1280 --pos 1368x1386 --rotate right --scale 0.6 --brightness 1 \
        --output DisplayPort-0 --off \
        --output DisplayPort-1 --off \
        --output DisplayPort-2 --primary --mode 1920x1080 --pos 1080x306 --rotate normal \
        --output DisplayPort-3 --mode 1920x1080 --pos 0x0 --rotate left
fi

