#!/bin/bash

sudo /usr/bin/find /usr/sbin -maxdepth 1 -type l -exec rm {} +

for file in ~/profile/sbin/*; do
    if [ -f "$file" ]; then
        sudo ln -s "$file" "/usr/sbin/$(basename $file)"
    fi
done

/usr/bin/find ~/.local/share/bin -maxdepth 1 -type l -exec rm {} + 
for file in ~/profile/bin/*; do 
    if [ -f "$file" ]; then 
	ln -s "$file" "/home/aemonge/.local/share/bin/$(basename $file)"
    fi
done
