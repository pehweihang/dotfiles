#!/bin/sh

nm-applet &
pasystray &
blueman-applet &
autorandr -c
dbus-update-activation-environment --all
picom --config $HOME/.config/picom/picom.conf &

xss-lock -- slock &
