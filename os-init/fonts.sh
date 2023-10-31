#!/bin/bash

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

meslo
