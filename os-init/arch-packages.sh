#!/bin/bash

_rwfus() {
    # Only RWFUS if we are on a valve steam deck
    echo "$(uname -r)" | grep '-valve' > /dev/null 2>&1
    if [ "$?" != "0" ]; then
        return 0
    fi

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
    sudo pacman -S --needed --noconfirm base-devel gcc glibc gcc-libs openssl libxcrypt-compat fakeroot
    echo "System packages installed successfully."
}

_dev_extra() {
    echo "Installing developer packages..."
    sudo pacman -S --needed --noconfirm firefox-developer-edition python-pip zsh xclip
    sudo pacman -S --needed --noconfirm the_silver_searcher entr neovim tig flameshot
    sudo pacman -S --needed --noconfirm glow onboard nodejs npm docker fzf rustup yakuake
    sudo pacman -S --needed --noconfirm shellcheck

    npm config set prefix ~/.node_modules
    npm i -g yarn
    sudo aura -A --noconfirm --needed firefox-pwa konsave neovim-remote
    echo "Developer packages installed successfully."
}

_user_extra() {
    echo "Installing user packages..."
    sudo pacman -S --noconfirm --needed hunspell-es_es languagetool qt5-imageformats
    sudo pacman -S --noconfirm --needed qt6-base qt6-declarative qt6-tools qt6-webview qt6-webengine
    sudo pacman -S --noconfirm --needed libsecret libcap wireguard-tools
    sudo pacman -S --noconfirm --needed  kde-pim-meta kdepim-runtime kdepim-addons kmail clementine
    sudo aura -A --noconfirm --needed clamav-desktop-bin kde-servicemenus-clamtkscan
    sudo aura -A --noconfirm --needed telegram-desktop-bin # mozillavpn
    sudo aura -A --noconfirm --needed --skippgpcheck spotify
    # sudo aura -A --noconfirm --needed slack-desktop
    echo "User packages installed successfully."
}

_audio() {
    sudo pacman -S gst-plugins-base gst-plugins-good gst-libav
}

_rwfus
_system
# _aura
_dev_extra
_audio
_user_extra
