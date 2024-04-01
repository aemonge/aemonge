#!/bin/bash

set -e

echo "sudo pacman -Syu --noconfirm"
sudo pacman -Syu --noconfirm

echo "sudo aura -Aua && aura -Ayu --noconfirm"
sudo aura -Aua
sudo aura -Ayu --noconfirm

echo "sudo snap refresh"
sudo snap refresh

echo "fwupdmgr update -y"
sudo fwupdmgr refresh
sudo fwupdmgr get-updates
sudo fwupdmgr update -y

# echo "pipupgrade -s && pipupgrade -y"
# pipupgrade -s && pipupgrade -y
#
# echo "npm update -g"
# sudo npm update

# echo "zinit update"
# zinit self-update
# zinit update
# zinit update --parallel 40
