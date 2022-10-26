#!/bin/sh

picom --config $HOME/.config/picom/picom.conf --experimental-backends &
nm-applet &
pasystray &
blueman-applet &
autorandr -c
dbus-update-activation-environment --all
