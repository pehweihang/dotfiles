#!/bin/sh

picom --config $HOME/.config/picom/picom.conf --experimental-backends &
nm-applet &
blueman-applet &
autorandr -c
