#!/bin/bash

set -e

echo "sudo pacman -Syu --noconfirm"
sudo pacman -Syu --noconfirm

echo "sudo aura -Syu --noconfirm"
sudo aura -Syu --noconfirm

echo "sudo snap refresh"
sudo snap refresh

echo "pipupgrade -s && pipupgrade -y"
pipupgrade -s && pipupgrade -y

echo "npm update -g"
sudo npm update -g

echo "zinit update"
zinit update
