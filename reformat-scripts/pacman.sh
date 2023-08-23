#!/bin/bash

_rwfux() {
  git clone https://github.com/ValShaped/rwfus.git /tmp/rwfux
  cd /tmp/rwfux
  sudo ./rwfus -iI
  # sudo ./rwfus -e
}

_aura() {
  git clone https://aur.archlinux.org/aura-bin.git /tmp/aura-bin
  cd /tmp/aura-bin
  makepkg
  sudo pacman -U *pkg.tar.zst
}

_system() {
  # Headers to build software like aura and other AURs
  sudo pacman -S --needed --noconfirm base-devel gcc glibc gcc-libs openssl
}

_dev_extra() {
  sudo pacman -S --needed --noconfirm firefox-developer-edition python-pip zsh xclip
  sudo pacman -S --needed --noconfirm the_silver_searcher entr neovim tig flameshot
  sudo pacman -S --needed --noconfirm glow onboard nodejs npm docker fzf rustup
  sudo npm i -g npm yarn

  sudo aura -A --noconfirm --needed firefox-pwa konsave neovim-remote
}

_user_extra() {
  sudo aura -A --noconfirm --needed kde-servicemenus-clamtkscan clamav-desktop-bin

  # User focused
  sudo aura -A --noconfirm --needed telegram-desktop-bin
  sudo aura -A --noconfirm --needed --skippgpcheck spotify

  # Work focused
  sudo aura -A --noconfirm --needed slack-desktop
}

_rwfux
_system
_aura
_dev_extra
_user_extra

sudo rwfus -d
