#!/bin/bash

_rwfux() {
  git clone https://github.com/ValShaped/rwfus.git /tmp/rwfux
  cd /tmp/rwfux
  ./rwfus -iI
  ./rwfus -e
}

_pikaur() {
  git clone https://aur.archlinux.org/pikaur.git /tmp/pikaur

  cd /tmp/pikaur
  makepkg -fsri
}

_system() {
  sudo pacman-key --init
  sudo pacman-key --populate

  # Headers to build software
  sudo pacman -S --needed --noconfirm base-devel git gcc glibc gcc-libs
  sudo pacman -S --needed --noconfirm linux-neptune-headers linux-headers linux-api-headers

  # Super extra but useful
  sudo pacman -S --noconfirm  libunistring pcre2 discover packagekit-qt5

  # Steam-OS oriented
  sudo pacman -S --needed --noconfirm linux-steamos libxcrypt-compat
  # pikaur -S --noconfirm linux-steamos libxcrypt-compat
}

_dev_extra() {

  # System though pikaur
  pikaur -S --noconfirm fzf firefox-pwa-bin konsave firefox-developer-edition boxes marktext-bin

  # Developer focused
  sudo pacman -S --noconfirm python-pip tig flameshot glow onboard nodejs npm docker

  # Main bash system-wide packages
  sudo pacman -S --needed --noconfirm zsh xclip the_silver_searcher entr neovim
  pip install neovim-remote
}

_user_extra() {
  # User focused
  pkcon --noninteractive install clamtk telegram-desktop spotify grip box

  # Work focused
  pkcon --noninteractive install slack
}

# steamos-readonly disable
_rwfux
_pikaur
_system
_dev_extra
_user_extra
# steamos-readonly enable
