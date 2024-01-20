#!/usr/bin/env bash

# Check release
if [ ! -f /etc/arch-release ] ; then
    exit 0
fi

# Check for updates
aur=`paru -Qua | wc -l`
ofc=`checkupdates -n | wc -l`

# Calculate total available updates
upd=$(( ofc + aur ))

# Show tooltip
if [ $upd -eq 0 ] ; then
    echo "{\"text\":\"$upd\", \"tooltip\":\" Packages are up to date\"}"
else
    echo "{\"text\":\"$upd\", \"tooltip\":\"󱓽 Official: $ofc\n󱓾 AUR: $aur$fpk_disp\"}"
fi
