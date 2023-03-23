#!/bin/bash

mkdir /tmp/meslo
cd /tmp/meslo
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.3.3/Meslo.zip
unzip Meslo.zip

mkdir -p ~/.local/share/fonts/
mkdir -p ~/.fonts/m/
cp -r Meslo\ LG\ [MS]\ DZ* ~/.fonts/m/.
cp -r Meslo\ LG\ [MS]\ DZ* ~/.local/share/fonts/
