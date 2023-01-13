#!/bin/sh
cd ~
mkdir -p ~/usr/lib/dotFiles
git clone git@github.com:aemonge/dotFiles.git ~/usr/lib/dotFiles

# XmodMap
mv ~/.Xmodmap ~/.Xmodmap.orig
ln -s ~/usr/lib/dotFiles/.Xmodmap .

# Profile
mv ~/.profile ~/.profile.orig
ln -s ~/usr/lib/dotFiles/.profile .

# ssh_config
mv ~/.ssh_config ~/.ssh_config.orig
ln -s ~/usr/lib/dotFiles/.ssh_config .

# userChrome
cd ~/.mozilla/firefox
for profile in *default; do
	pushd $profile; 
	mkdir chrome; 
	pushd chrome; 
	ln -s ~/usr/lib/dotFiles/userChrome.css .;
       	popd && popd; 
done
cd ~

#xbindkeys
mv ~/.xbindkeysrc ~/.xbindkeysrc.orig
ln -s ~/usr/lib/dotFiles/.xbindkeysrc .

#xinitrc
mv ~/.xinitrc ~/.xinitrc.orig
ln -s ~/usr/lib/dotFiles/.xinitrc .

# zathurarc
mv ~/.zathurarc ~/.zathurarc.orig
ln -s ~/usr/lib/dotFiles/.zathurarc .

# devilspie
mv ~/.devilspie ~/.devilspie.orig
ln -s ~/usr/lib/dotFiles/.devilspie .

# gitconfig
mv ~/.gitconfig ~/.gitconfig.orig
ln -s ~/usr/lib/dotFiles/.gitconfig .

# xmodmap
mv ~/.Xmodmap ~/.Xmodmap.orig
ln -s ~/usr/lib/dotFiles/.Xmodmap .

# zsh
mv ~/.zsh ~/.zsh.orig
ln -s ~/usr/lib/dotFiles/.zshrc .
