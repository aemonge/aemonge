#!/bin/bash

THREE_MONITORS() {
  STATUS=$(xrandr --query | grep 'DisplayPort-\([0-9]*\) \(dis\|\)connected')
  CONNECTED=0

  while read -r line; do
    # Get the port name and status
    port=$(echo $line | awk '{print $1}')
    status=$(echo $line | awk '{print $2}')

    # Check if the port is one of the DisplayPorts and is connected
    if [[ "$port" =~ "DisplayPort-" && "$status" == "connected" ]]; then
      CONNECTED=$(($CONNECTED + 1))
    fi
  done <<< "$STATUS"

  if [ $CONNECTED -ge 2 ]; then
    xrandr --output eDP --scale 0.7
  else
    echo "Listed $CONNECTED with $STATUS"
  fi
}

THREE_MONITORS
