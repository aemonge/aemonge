#!/bin/bash

set -e

echo "sudo pacman -Syu --noconfirm"
sudo pacman -Syu --noconfirm

echo "sudo aura -Syu --noconfirm"
sudo aura -Syu --noconfirm

echo "npm update -g"
npm update -g

echo "pipupgrade -s && pipupgrade -y"
pipupgrade -s && pipupgrade -y
