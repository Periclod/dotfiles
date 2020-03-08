#!/bin/bash

# generate color scheme
wal -i ~/Wallpapers --saturate 0.5

# restart funst to update notifications
$HOME/.local/scripts/dunst.sh

# set new lockscreen
betterlockscreen -u ~/Wallpapers/ -r 1920x1080



