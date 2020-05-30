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

mkdir -p ~/.config/rofi/
ln -s $(pwd)/config/rofi/config.rasi ~/.config/rofi/

mkdir -p ~/.config/redshift/
ln -s $(pwd)/config/redshift/redshift.conf ~/.config/redshift/redshift.conf

mkdir -p ~/.config/nvim/
ln -s $(pwd)/config/nvim/init.vim ~/.config/nvim/init.vim

mkdir -p ~/.local/scripts/
ln -s $(pwd)/scripts/* ~/.local/scripts/


# set git diff tool
git config --global core.pager "diff-so-fancy | less --tabs=4 -RFX"


echo "Don't forget to symlink jetbrains/vim_settings.xml to ~/.IntelliJIdea{VERSION}/config/options"

