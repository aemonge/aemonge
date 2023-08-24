#!/bin/bash

_rwfux() {
    echo "Cloning and installing rwfus..."
    git clone https://github.com/ValShaped/rwfus.git /tmp/rwfus
    cd /tmp/rwfus || echo "Error: failed to create directory /tmp/rwfus" && exit
    if ! sudo ./rwfus -iI; then
        echo "Error: Failed to install rwfus"
        exit 1
    fi
    echo "rwfus installed successfully."
}

_aura() {
    echo "Cloning and installing aura..."
    git clone https://aur.archlinux.org/aura-bin.git /tmp/aura-bin
    cd /tmp/aura-bin || echo "Error: failed to create directory /tmp/aura-bin" && exit
    if ! makepkg; then
        echo "Error: Failed to make package for aura"
        exit 1
    fi
    sudo pacman -U "*pkg.tar.zst"
    echo "aura installed successfully."
}

_system() {
    echo "Installing system packages..."
    sudo pacman -S --needed --noconfirm base-devel gcc glibc gcc-libs openssl
    echo "System packages installed successfully."
}

_dev_extra() {
    echo "Installing developer packages..."
    sudo pacman -S --needed --noconfirm firefox-developer-edition python-pip zsh xclip
    sudo pacman -S --needed --noconfirm the_silver_searcher entr neovim tig flameshot
    sudo pacman -S --needed --noconfirm glow onboard nodejs npm docker fzf rustup

    sudo npm i -g npm yarn
    sudo aura -A --noconfirm --needed firefox-pwa konsave neovim-remote
    echo "Developer packages installed successfully."
}

_user_extra() {
    echo "Installing user packages..."
    sudo aura -A --noconfirm --needed kde-servicemenus-clamtkscan clamav-desktop-bin
    sudo aura -A --noconfirm --needed telegram-desktop-bin
    sudo aura -A --noconfirm --needed --skippgpcheck spotify
    sudo aura -A --noconfirm --needed slack-desktop
    echo "User packages installed successfully."
}

_rwfux
_system
_aura
_dev_extra
_user_extra
