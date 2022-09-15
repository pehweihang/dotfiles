#!/bin/sh

picom --config $HOME/.config/picom/picom.conf --experimental-backends &
nm-applet &
pasystray &
blueman-applet &
telegram-desktop &
bitwarden-desktop &
autorandr -c
