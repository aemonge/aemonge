#!/bin/bash

_rwfux() {
  git clone https://github.com/ValShaped/rwfus.git /tmp/rwfux
  cd /tmp/rwfux
  ./rwfus -iI
  ./rwfus -e
}

_pacman() {
  sudo pacman-key --init
  sudo pacman-key --populate
  sudo pacman -S --needed base-devel git
  sudo pacman -S base-devel linux-headers gcc glibc gcc-libs
  sudo pacman -S python-pip zsh git tig \
   flameshot glow xclip onboard \
   nodejs npm the_silver_searcher neovim \
   entr
}

_pikaur() {
   git clone https://aur.archlinux.org/pikaur.git /tmp/pikaur

   cd /tmp/pikaur
   makepkg -fsri

   pikaur -S --noconfirm fzf firefox-pwa-bin konsave firefox-developer-edition \
     telegram-desktop
   pikaur -S --noconfirm spotify
}

# steamos-readonly disable
_rwfux
_pacman
_pikaur
# steamos-readonly enable
