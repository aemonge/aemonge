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
  pacman -S linux-headers gcc base-devel git glibc gcclibs
  pacman -S python-pip zsh git tig \
   flameshot glow xclip onboard \
   nodejs npm the_silver_searcher neovim \
   entr
}

_pikaur() {
   git clone https://aur.archlinux.org/pikaur.git /tmp/pikaur
   cd /tmp/pikaur
   makepkg -fsri

   pikaur -S --noconfirm fzf firefox-pwa-bin konsave firefox-developer-edition \
     spotify telegram-desktop
}

# steamos-readonly disable
sudo _rwfux
sudo _pacman
_pikaur
# steamos-readonly enable
