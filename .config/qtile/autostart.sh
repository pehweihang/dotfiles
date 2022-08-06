#!/bin/sh

picom --config $HOME/.config/picom/picom.conf --experimental-backends &
autorandr -c
$HOME/.config/qtile/dunst.sh
