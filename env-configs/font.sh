#!/bin/bash

mkdir /tmp/meslo ~/.fonts/m
cd /tmp/meslo
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.3.3/Meslo.zip
unzip Meslo.zip
cp Meslo_LG_M_DZ* ~/.fonts/m/.
cp Meslo_LG_M_DZ* ~/.local/share/fonts/
