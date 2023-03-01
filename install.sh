#!/bin/sh

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
  P="$HOME/u/env-configs"
  for f in $(ls -a $P); do
    if [[ -f "$P/$f"  ]]; then
      rm ~/$f 2> /dev/null;
      ln -s $P/$f ~/$f;
    fi;
  done;
}

firefox() {
  cd /home/deck/.mozilla/firefox/*.dev-edition-default/
  mkdir -p chrome 2> /dev/null
  cd chrome
  rm userChrome.css 2> /dev/null
  ln -s $HOME/u/app-configs/userChrome_customization.css userChrome.css
}

nvim() {
  rm -rf ~/.config/nvim 2> /dev/null
  ln -s ~/u/nvim ~/.config/.
}

devConfig
envConfig
nvim
kde
firefox
