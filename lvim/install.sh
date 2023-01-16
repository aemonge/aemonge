#!/bin/bash
cd $HOME/aemonge/lvim

# # Clean
sh <(curl -s https://raw.githubusercontent.com/lunarvim/lunarvim/master/utils/installer/uninstall.sh)
rm -Rf ~/.config/lvim ~/.local/bin/lvim ~/.local/share/lunarvim ~/.cache/lvim
rm -f ~/.config/lvim/lvim.config.lua

# # # Install
bash <(curl -s https://raw.githubusercontent.com/lunarvim/lunarvim/master/utils/installer/install.sh)

# # My settings
rm $HOME/.config/lvim/config.lua
ln -s $(pwd)/init.config.lua $HOME/.config/lvim/config.lua
mkdir $HOME/.config/lvim/settings

for f in $(ls ./settings); do
  ln -s $(pwd)/settings/$f $HOME/.config/lvim/settings/.
done

for f in $(ls ./bin); do
  ln -s $(pwd)/bin/$f $HOME/bin/.
done

MUX
