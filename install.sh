#!/bin/sh

devConfig() {
  P="$HOME/aemonge/dev-configs"
  for f in $(ls -a $P); do
    if [[ -f "$P/$f"  ]]; then
      rm ~/$f;
      ln -s $P/$f ~/$f;
    fi;
  done;
}

envConfig() {
  P="$HOME/aemonge/env-configs"
  for f in $(ls -a $P); do
    if [[ -f "$P/$f"  ]]; then
      rm ~/$f;
      ln -s $P/$f ~/$f;
    fi;
  done;
}

firefox() {
  cd /Users/aemonge/Library/Application\ Support/Firefox/Profiles/*dev-edition-default/
  mkdir -p chrome
  cd chrome
  ln -s $HOME/aemonge/configs/userChrome_customization.css userChrome.css
}

devConfig
envConfig
firefox
