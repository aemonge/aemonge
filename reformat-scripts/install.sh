#!/bin/bash


system() {
  set -e

  rm -rf /etc/sddm.conf.d/zz-steamos-autologin.conf
  ln -s ~/usr/env-configs/zz-steamos-autologin.conf /etc/sddm.conf.d/zz-steamos-autologin.conf
  ./env-configs/pacman.sh
}

fonts() {
  ./env-configs/font.sh
}

kde() {
  konsave -i ~/usr/reformat-scripts/deck.knsv
  konsave -a deck
}


configs() {
  # Applications
  P="/home/deck/usr/configs/applications/"
  for f in $(ls -a $P); do
    if [[ -f "$P/$f"  ]]; then
      rm ~/$f 2> /dev/null;
      ln -s $P/$f ~/$f;
    fi;
  done;

  # Bash
  P="/home/deck/usr/configs/bash/"
  for f in $(ls -a $P); do
    if [[ -f "$P/$f"  ]]; then
      rm ~/$f 2> /dev/null;
      ln -s $P/$f ~/$f;
    fi;
  done;

  # Devtools
  P="/home/deck/usr/configs/dev-tools/"
  for f in $(ls -a $P); do
    if [[ -f "$P/$f"  ]]; then
      rm ~/$f 2> /dev/null;
      ln -s $P/$f ~/$f;
    fi;
  done;
}

firefox() {
  cd /home/deck/.mozilla/firefox/40f5zrsq.deck*
  mkdir -p chrome 2> /dev/null
  cd chrome
  rm userChrome.css 2> /dev/null
  ln -s $HOME/usr/app-configs/userChrome_customization.css userChrome.css
}

nvim() {
  # pip install neovim-remote
  mkdir -p ~/.config/nvim/spell

  rm -rf ~/.config/nvim 2> /dev/null
  rm -rf ~/.cache/nvim 2> /dev/null
  rm -rf ~/.local/share/nvim 2> /dev/null
  rm -rf ~/.local/state/nvim 2> /dev/null

  ln -s ~/usr/nvim ~/.config/.
}

# system
# fonts
configs
nvim
# kde
# firefox
