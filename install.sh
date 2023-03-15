#!/bin/bash

system() {
  ./env-configs/pacman.sh
}

fonts() {
  ./env-configs/font.sh
}

kde() {
  pip install konsave
  konsave -i ~/u/app-configs/deck.knsv
}

devConfig() {
  P="$HOME/u/dev-configs"
  for f in $(ls -a $P); do
    if [[ -f "$P/$f"  ]]; then
      rm ~/$f 2> /dev/null;
      ln -s $P/$f ~/$f;
    fi;
  done;
}

envConfig() {
  ln -s ~/u/env-configs/pikaur.conf ~/.config/pikaur.conf
  P="$HOME/u/env-configs"
  for f in $(ls -a $P); do
    if [[ -f "$P/$f"  ]]; then
      rm ~/$f 2> /dev/null;
      ln -s $P/$f ~/$f;
    fi;
  done;
}

firefox() {
  cd /home/deck/.mozilla/firefox/avosv1da.deck
  mkdir -p chrome 2> /dev/null
  cd chrome
  rm userChrome.css 2> /dev/null
  ln -s $HOME/u/app-configs/userChrome_customization.css userChrome.css
}

nvim() {
  rm -rf ~/.config/nvim 2> /dev/null
  rm -rf ~/.cache/nvim 2> /dev/null
  rm -rf ~/.local/share/nvim 2> /dev/null
  rm -rf ~/.local/state/nvim 2> /dev/null

  ln -s ~/u/nvim ~/.config/.
}

system
fonts
devConfig
envConfig
nvim
kde
# firefox
