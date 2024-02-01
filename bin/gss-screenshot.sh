#!/bin/bash
# Save the screenshot to a temporary file
IMAGE_PATH=$(mktemp /tmp/screenshot-XXXXXX.png)

# Use slurp to select an area and grim to take a screenshot of that area
grim -g "$(slurp)" "$IMAGE_PATH"

# Open the screenshot in swappy for annotation
swappy -f "$IMAGE_PATH"

# Optionally, you can copy the screenshot to the clipboard or save it to a specific location
wl-copy < "$IMAGE_PATH"
