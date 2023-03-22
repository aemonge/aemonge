#!/bin/bash

_rwfux() {
  git clone https://github.com/ValShaped/rwfus.git /tmp/rwfux
  cd /tmp/rwfux
  ./rwfus -iI
  ./rwfus -e
}

_pacman() {
  pacman-key --init
  pacman-key --populate
  pacman -S linux-headers gcc base-devel git
  pacman -S python-pip zsh git tig \
   flameshot glow xclip onboard \
   nodejs npm the_silver_searcher neovim \
   entr
}

_pickaur() {
   git clone https://aur.archlinux.org/pikaur.git /tmp/pika
   cd /tmp/pik
   makepkg -fsri

   pikaur -S --noconfirm fzf firefox-pwa-bin
}

steamos-readonly disable
_rwfux
_pacman
_pikaur
steamos-readonly enable
