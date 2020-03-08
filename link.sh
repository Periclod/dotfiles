#!/bin/bash

ln -s $(pwd)/vimrc ~/.vimrc
ln -s $(pwd)/zshrc ~/.zshrc
ln -s $(pwd)/ideavimrc ~/.ideavimrc

mkdir -p ~/.config/i3/
ln -s $(pwd)/config/i3/config ~/.config/i3/

mkdir -p ~/.config/i3status/
ln -s $(pwd)/config/i3status/config ~/.config/i3status/

mkdir -p ~/.config/picom/
ln -s $(pwd)/config/picom/picom.conf ~/.config/picom/

mkdir -p ~/.config/dunst/
ln -s $(pwd)/config/dunst/dunstrc ~/.config/dunst/



mkdir -p ~/.local/scripts/
ln -s $(pwd)/scripts/* ~/.local/scripts/


