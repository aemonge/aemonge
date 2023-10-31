#!/bin/bash

for file in *.mp4; do
    if [ ! -f "${file%.*}.webp" ]; then
        ffmpeg -i "$file" -vf "fps=10" -c:v libwebp -preset default -lossless 1 -loop 0 -an "${file%.*}.webp"
    else
        echo "${file%.*}.webp already exists. Skipping..."
    fi
done
