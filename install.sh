#!/bin/bash

system() {
  rm -rf /etc/sddm.conf.d/zz-steamos-autologin.conf
  ln -s ~/usr/env-configs/zz-steamos-autologin.conf /etc/sddm.conf.d/zz-steamos-autologin.conf
  ./env-configs/pacman.sh
}

fonts() {
  ./env-configs/font.sh
}

kde() {
  konsave -i ~/usr/app-configs/deck.knsv
  konsave -a deck
}

devConfig() {
  P="$HOME/usr/dev-configs"
  for f in $(ls -a $P); do
    if [[ -f "$P/$f"  ]]; then
      rm ~/$f 2> /dev/null;
      ln -s $P/$f ~/$f;
    fi;
  done;
}

envConfig() {
  rm ~/.config/pikaur.conf && ln -s ~/usr/env-configs/pikaur.conf ~/.config/pikaur.conf
  P="$HOME/usr/env-configs"
  for f in $(ls -a $P); do
    if [[ -f "$P/$f"  ]]; then
      rm ~/$f 2> /dev/null;
      ln -s $P/$f ~/$f;
    fi;
  done;
}

firefox() {
  cd /home/deck/.mozilla/firefox/*.deck
  mkdir -p chrome 2> /dev/null
  cd chrome
  rm userChrome.css 2> /dev/null
  ln -s $HOME/usr/app-configs/userChrome_customization.css userChrome.css
}

nvim() {
  pip install neovim-remote
  rm -rf ~/.config/nvim 2> /dev/null
  rm -rf ~/.cache/nvim 2> /dev/null
  rm -rf ~/.local/share/nvim 2> /dev/null
  rm -rf ~/.local/state/nvim 2> /dev/null

  ln -s ~/usr/nvim ~/.config/.
}

# sudo system
# fonts
devConfig
envConfig
nvim
# kde
firefox
