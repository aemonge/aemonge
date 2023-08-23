#!/bin/bash

system() {
    set -e

    rm -rf /etc/sddm.conf.d/zz-steamos-autologin.conf
    ln -s ~/usr/env-configs/zz-steamos-autologin.conf /etc/sddm.conf.d/zz-steamos-autologin.conf
    ./pacman.sh
}

kde() {
    konsave -i ~/usr/reformat-scripts/deck.knsv
    konsave -a deck
}

configs() {
    # Applications, Bash, Devtools
    P="/home/deck/usr/configs/applications/"

    for P in "/home/deck/usr/configs/applications/" "/home/deck/usr/configs/bash/" "/home/deck/usr/configs/dev-tools/"; do
        for f in $(ls -a $P); do
            if [[ -f "$P/$f" ]]; then
                rm "$HOME/$f" 2>/dev/null
                ln -s "$P/$f" "$HOME/$f"
            fi
        done
    done
}

firefox() {
    cd /home/deck/.mozilla/firefox/40f5zrsq.deck*
    mkdir -p chrome 2>/dev/null
    cd chrome
    rm userChrome.css 2>/dev/null
    ln -s "$HOME/usr/configs/applications/firefox/chrome/userChrome.css" userChrome.css
}

nvim() {
    # pip install neovim-remote
    mkdir -p ~/.config/nvim/spell

    rm -rf ~/.config/nvim 2>/dev/null
    rm -rf ~/.cache/nvim 2>/dev/null
    rm -rf ~/.local/share/nvim 2>/dev/null
    rm -rf ~/.local/state/nvim 2>/dev/null

    ln -s ~/usr/nvim ~/.config/.
}

# system
# ./font.sh
configs
nvim
# kde
# firefox
