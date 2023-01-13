#!/bin/bash
cd ~/usr/projects/aemonge/lvim

# # Clean
sh <(curl -s https://raw.githubusercontent.com/lunarvim/lunarvim/master/utils/installer/uninstall.sh)
rm -Rf ~/.config/lvim ~/.local/bin/lvim ~/.local/share/lunarvim ~/.cache/lvim
rm -f ~/.config/lvim/lvim.config.lua

# # # Install
bash <(curl -s https://raw.githubusercontent.com/lunarvim/lunarvim/master/utils/installer/install.sh)

# # My settings
rm ~/.config/lvim/config.lua
ln -s $(pwd)/init.config.lua ~/.config/lvim/config.lua
mkdir ~/.config/lvim/settings

for f in $(ls ./settings); do
  ln -s $(pwd)/settings/$f ~/.config/lvim/settings/.
done
