#!/bin/bash

iosevka_term() {
  local url="https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/IosevkaTerm.zip"
  echo "Downloading and installing IosevkaTerm font..."

  local temp_dir="/tmp/iosevka"
  mkdir "$temp_dir" || rm -rf $temp_dir && mkdir $temp_dir
  cd $temp_dir || (echo "Error: Failed to create $temp_dir directory" && exit 1)
  wget "$url"
  unzip IosevkaTerm.zip

  local fonts_dir="$HOME/.local/share/fonts/"
  local old_fonts_dir="$HOME/.fonts/m/"
  mkdir -p "$fonts_dir"
  mkdir -p "$old_fonts_dir"

  cp -r IosevkaTermNerdFont* "$old_fonts_dir"
  cp -r IosevkaTermNerdFont* "$fonts_dir"

  echo "IosevkaTerm font installed successfully."
}

zed_mono() {
  local url="https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/ZedMono.zip"
  echo "Downloading and installing ZedMono font..."

  local temp_dir="/tmp/zedmono"
  mkdir "$temp_dir" || rm -rf $temp_dir && mkdir $temp_dir
  cd $temp_dir || (echo "Error: Failed to create $temp_dir directory" && exit 1)
  wget "$url"
  unzip ZedMono.zip

  local fonts_dir="$HOME/.local/share/fonts/"
  local old_fonts_dir="$HOME/.fonts/m/"
  mkdir -p "$fonts_dir"
  mkdir -p "$old_fonts_dir"

  cp -r ZedMonoNerdFontMono* "$old_fonts_dir"
  cp -r ZedMonoNerdFontMono* "$fonts_dir"

  echo "ZedMono font installed successfully."
}

meslo () {
  echo "Downloading and installing Meslo font..."

  local temp_dir="/tmp/meslo"
  mkdir "$temp_dir" || rm -rf $temp_dir && mkdir $temp_dir
  cd $temp_dir || (echo "Error: Failed to create $temp_dir directory" && exit 1)
  wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.3.3/Meslo.zip
  unzip Meslo.zip

  local fonts_dir="$HOME/.local/share/fonts/"
  local old_fonts_dir="$HOME/.fonts/m/"
  mkdir -p "$fonts_dir"
  mkdir -p "$old_fonts_dir"

  cp -r Meslo\ LG\ [MS]\ DZ* "$old_fonts_dir"
  cp -r Meslo\ LG\ [MS]\ DZ* "$fonts_dir"

  echo "Meslo font installed successfully."
}


# meslo
# iosevka_term
zed_mono
# sudo pacman -S ttc-iosevka
