#!/bin/bash

pacman -Syu --noconfirm
aura -Syu --noconfirm
npm update -g
sudo -u aemonge /opt/miniconda3/bin/pipupgrade -s
sudo -u aemonge /opt/miniconda3/bin/pipupgrade -y
sudo -u aemonge /opt/miniconda3/bin/pipupgrade --doctor -y
