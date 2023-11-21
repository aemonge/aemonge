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
    sudo pacman -S --needed --noconfirm base-devel gcc glibc gcc-libs openssl
    sudo pacman -S --needed --noconfirm libxcrypt-compat fakeroot packagekit-qt5
    sudo pacman -S --needed --noconfirm make libcap extra-cmake-modules vulkan-headers
    echo "System packages installed successfully."
}

_dev_extra() {
    echo "Installing developer packages..."
    sudo pacman -S --needed --noconfirm python-pip zsh xclip the_silver_searcher neovim
    sudo pacman -S --needed --noconfirm fzf rustup entr tig shellcheck ripgrep
    pip install neovim-remote
    sudo aura -A --noconfirm --needed miniconda3
    echo "Developer packages installed successfully."
}

_kde() {
    # Steam GPU https://github.com/catsout/wallpaper-engine-kde-plugin
    # https://github.com/ghostlexly/gpu-video-wallpaper
    # Okey-ish https://github.com/PeterTucker/smartER-video-wallpaper
    echo "Installing kde packages..."
    sudo pacman -S --needed --noconfirm flameshot libx11 mpv pyqt5 trash-cli
    sudo pacman -S --needed --noconfirm xdg-desktop-portal xdg-desktop-portal-kde
    # sudo aura -A --noconfirm --needed xwinwrap-0.9-bin ghostlexly-gpu-video-wallpaper
    sudo pacman -S --needed --noconfirm qt5-declarative python-websockets plasma-framework
    sudo pacman -S --needed --noconfirm qt5-websockets qt5-webchannel
    sudo aura -A --noconfirm --needed plasma5-wallpapers-wallpaper-engine-git
    pip install konsave pyqt5

    # Force using dolphin to choose files
    sudo bash -c 'printf "GTK_USE_PORTAL=1" >> /etc/environment'
    echo "Developer kde installed successfully."
}

_media_extra() {
    echo "Installing media packages..."
    sudo pacman -S --noconfirm --needed gst-plugins-base gst-plugins-good gst-libav
    sudo pacman -S --noconfirm --needed kimageformats qt5-imageformats libwebp imagemagick
    sudo pacman -S --noconfirm --needed qt6-imageformats libwebp imagemagick
    sudo pacman -S --noconfirm --needed kdegraphics-thumbnailers ffmpegthumbs imagemagick ffmpeg
    sudo pacman -S --noconfirm --needed libsecret libcap wireguard-tools ffmpegthumbnailer
    sudo pacman -S --noconfirm --needed hunspell-en_us hunspell-es_es languagetool
    echo "Media packages installed successfully."
}


_user_extra() {
    echo "Installing user packages..."
    sudo pacman -S --noconfirm --needed firefox kdeconnect
    sudo pacman -S --noconfirm --needed kde-pim-meta kdepim-runtime kdepim-addons
    sudo pacman -S --noconfirm --needed clementine
    sudo aura -A --noconfirm --needed clamav-desktop-bin kde-servicemenus-clamtkscan
    echo "User packages installed successfully."
}

_discover() {
  echo "discover package"
  # https://apps.kde.org/discover/
  # telegram-desktop-bin slack-desktop spotify
  # sudo aura -A --noconfirm --needed telegram-desktop-bin # mozillavpn
  # sudo aura -A --noconfirm --needed spotify
  # sudo aura -A --noconfirm --needed slack-desktop firefox-pwa
  # sudo pacman -S --needed --noconfirm nodejs npm docker
}

# _rwfus
_system
_aura
_dev_extra
_kde
_media_extra
_user_extra
# _discover
