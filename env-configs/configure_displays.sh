#!/bin/bash

export DISPLAY=:0
export XAUTHORITY=$(ps -C Xorg -f --no-header | sed -n 's/.*-auth //; s/ -[^ ].*//; p')

SCREEN_STATUS=$(xrandr --query | grep 'DisplayPort-\([0-9]*\) \(dis\|\)connected')
CONNECTED=0

while read -r line; do
  # Get the port name and status
  port=$(echo $line | awk '{print $1}')
  conn_status=$(echo $line | awk '{print $2}')

  # Check if the port is one of the DisplayPorts and is connected
  if [[ "$port" =~ "DisplayPort-" && "$conn_status" == "connected" ]]; then
    CONNECTED=$(($CONNECTED + 1))
  fi
done <<< "$SCREEN_STATUS"

if [ $CONNECTED -ge 1 ]; then
  # KDE Will be first, sleep 3s make us second
  sleep 3s && xrandr --output eDP --scale 0.7
else
  echo "Listed $CONNECTED with $SCREEN_STATUS"
fi