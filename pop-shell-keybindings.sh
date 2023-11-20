#!/bin/bash
#
# dconf branches
KEYS_POP=/org/gnome/shell/extensions/pop-shell
KEYS_GNOME_WM=/org/gnome/desktop/wm/keybindings
KEYS_GNOME_SHELL=/org/gnome/shell/keybindings
KEYS_MUTTER=/org/gnome/mutter/keybindings
KEYS_MEDIA=/org/gnome/settings-daemon/plugins/media-keys

# disable unwanted shortcuts
dconf write ${KEYS_MEDIA}/help "@as []"
dconf write ${KEYS_MEDIA}/magnifier "@as []"
dconf write ${KEYS_MEDIA}/magnifier-zoom-in "@as []"
dconf write ${KEYS_MEDIA}/magnifier-zoom-out "@as []"
dconf write ${KEYS_MEDIA}/screenreader "@as []"
dconf write ${KEYS_GNOME_WM}/activate-window-menu "@as []"
dconf write ${KEYS_GNOME_WM}/begin-move "@as []"
dconf write ${KEYS_GNOME_WM}/begin-resize "@as []"
dconf write ${KEYS_GNOME_WM}/cycle-group "@as []"
dconf write ${KEYS_GNOME_WM}/cycle_group-backward "@as []"
dconf write ${KEYS_GNOME_WM}/cycle-panels "@as []"
dconf write ${KEYS_GNOME_WM}/cycle-panels-backward "@as []"
dconf write ${KEYS_GNOME_WM}/cycle-windows "@as []"
dconf write ${KEYS_GNOME_WM}/cycle-windows-backward "@as []"
dconf write ${KEYS_GNOME_WM}/switch-input-source "['XF86Keyboard']"
dconf write ${KEYS_GNOME_WM}/switch-input-source "['<Shift>XF86Keyboard']"

# disable incompatible and conflicting shortcuts
dconf write /org/gnome/mutter/wayland/keybindings/restore-shortcuts "@as []"
dconf write ${KEYS_GNOME_SHELL}/switch-to-application-1 "@as []"
dconf write ${KEYS_GNOME_SHELL}/switch-to-application-2 "@as []"
dconf write ${KEYS_GNOME_SHELL}/switch-to-application-3 "@as []"
dconf write ${KEYS_GNOME_SHELL}/switch-to-application-4 "@as []"
dconf write ${KEYS_GNOME_SHELL}/switch-to-application-5 "@as []"
dconf write ${KEYS_GNOME_SHELL}/switch-to-application-6 "@as []"
dconf write ${KEYS_GNOME_SHELL}/switch-to-application-7 "@as []"
dconf write ${KEYS_GNOME_SHELL}/switch-to-application-8 "@as []"
dconf write ${KEYS_GNOME_SHELL}/switch-to-application-9 "@as []"
dconf write ${KEYS_GNOME_SHELL}/switch-to-application-10 "@as []"
dconf write ${KEYS_GNOME_SHELL}/open-application-menu "@as []"
dconf write ${KEYS_MEDIA}/rotate-video-lock-static "@as []"
dconf write ${KEYS_MUTTER}/toggle-tiled-left "@as []"
dconf write ${KEYS_MUTTER}/toggle-tiled-right "@as []"
dconf write ${KEYS_GNOME_WM}/minimize "@as []"
dconf write ${KEYS_GNOME_WM}/maximize "@as []"
dconf write ${KEYS_GNOME_WM}/move-to-monitor-down "@as []"
dconf write ${KEYS_GNOME_WM}/move-to-monitor-left "@as []"
dconf write ${KEYS_GNOME_WM}/move-to-monitor-right "@as []"
dconf write ${KEYS_GNOME_WM}/move-to-monitor-up "@as []"
dconf write ${KEYS_GNOME_WM}/move-to-workspace-down "@as []"
dconf write ${KEYS_GNOME_WM}/move-to-workspace-left "@as []"
dconf write ${KEYS_GNOME_WM}/move-to-workspace-right "@as []"
dconf write ${KEYS_GNOME_WM}/move-to-workspace-up "@as []"
dconf write ${KEYS_GNOME_WM}/switch-application "@as []"
dconf write ${KEYS_GNOME_WM}/switch-application-backward "@as []"
dconf write ${KEYS_GNOME_WM}/switch-group "@as []"
dconf write ${KEYS_GNOME_WM}/switch-group-backward "@as []"
dconf write ${KEYS_GNOME_WM}/switch-panels "@as []"
dconf write ${KEYS_GNOME_WM}/switch-panels-backward "@as []"
dconf write ${KEYS_GNOME_WM}/switch-to-workspace-down "@as []"
dconf write ${KEYS_GNOME_WM}/switch-to-workspace-left "@as []"
dconf write ${KEYS_GNOME_WM}/switch-to-workspace-right "@as []"
dconf write ${KEYS_GNOME_WM}/switch-to-workspace-up "@as []"
dconf write ${KEYS_GNOME_WM}/unmaximize "@as []"

# switch workspace shortcus
dconf write ${KEYS_GNOME_SHELL}/switch-to-workspace-1 "['<Super>1']"
dconf write ${KEYS_GNOME_SHELL}/switch-to-workspace-2 "['<Super>2']"
dconf write ${KEYS_GNOME_SHELL}/switch-to-workspace-3 "['<Super>3']"
dconf write ${KEYS_GNOME_SHELL}/switch-to-workspace-4 "['<Super>4']"
dconf write ${KEYS_GNOME_SHELL}/switch-to-workspace-5 "['<Super>5']"
dconf write ${KEYS_GNOME_SHELL}/switch-to-workspace-6 "['<Super>6']"
dconf write ${KEYS_GNOME_SHELL}/switch-to-workspace-7 "['<Super>7']"
dconf write ${KEYS_GNOME_SHELL}/switch-to-workspace-8 "['<Super>8']"
dconf write ${KEYS_GNOME_SHELL}/switch-to-workspace-9 "['<Super>9']"
dconf write ${KEYS_GNOME_SHELL}/switch-to-workspace-10 "['<Super>0']"
dconf write ${KEYS_GNOME_WM}/switch-to-workspace-1 "['<Super>1']"
dconf write ${KEYS_GNOME_WM}/switch-to-workspace-2 "['<Super>2']"
dconf write ${KEYS_GNOME_WM}/switch-to-workspace-3 "['<Super>3']"
dconf write ${KEYS_GNOME_WM}/switch-to-workspace-4 "['<Super>4']"
dconf write ${KEYS_GNOME_WM}/switch-to-workspace-5 "['<Super>5']"
dconf write ${KEYS_GNOME_WM}/switch-to-workspace-6 "['<Super>6']"
dconf write ${KEYS_GNOME_WM}/switch-to-workspace-7 "['<Super>7']"
dconf write ${KEYS_GNOME_WM}/switch-to-workspace-8 "['<Super>8']"
dconf write ${KEYS_GNOME_WM}/switch-to-workspace-9 "['<Super>9']"
dconf write ${KEYS_GNOME_WM}/switch-to-workspace-10 "['<Super>0']"

dconf write ${KEYS_GNOME_WM}/move-to-workspace-1 "['<Super><Shift>1']"
dconf write ${KEYS_GNOME_WM}/move-to-workspace-2 "['<Super><Shift>2']"
dconf write ${KEYS_GNOME_WM}/move-to-workspace-3 "['<Super><Shift>3']"
dconf write ${KEYS_GNOME_WM}/move-to-workspace-4 "['<Super><Shift>4']"
dconf write ${KEYS_GNOME_WM}/move-to-workspace-5 "['<Super><Shift>5']"
dconf write ${KEYS_GNOME_WM}/move-to-workspace-6 "['<Super><Shift>6']"
dconf write ${KEYS_GNOME_WM}/move-to-workspace-7 "['<Super><Shift>7']"
dconf write ${KEYS_GNOME_WM}/move-to-workspace-8 "['<Super><Shift>8']"
dconf write ${KEYS_GNOME_WM}/move-to-workspace-9 "['<Super><Shift>9']"
dconf write ${KEYS_GNOME_WM}/move-to-workspace-10 "['<Super><Shift>0']"

# toggle full screen
dconf write ${KEYS_GNOME_WM}/toggle-maximized "['<Super>Space']"

# toggle float
dconf write ${KEYS_POP}/toggle-floating "['<Super>t']"

# toggle tile adjustment mode
dconf write ${KEYS_POP}/tile-enter "['<Super>Return']"
dconf write ${KEYS_POP}/tile-accept "['Return']"
dconf write ${KEYS_POP}/tile-reject "['Escape']"

# move tiles
dconf write ${KEYS_POP}/tile-move-left    "['<Shift>Left', '<Shift>h']"
dconf write ${KEYS_POP}/tile-move-right   "['<Shift>Right', '<Shift>l']"
dconf write ${KEYS_POP}/tile-move-up      "['<Shift>Up', '<Shift>k']"
dconf write ${KEYS_POP}/tile-move-down    "['<Shift>Down', '<Shift>j']"

# resize tiles
dconf write ${KEYS_POP}/tile-resize-left  "['<Primary>Left', '<Primary>h']"   
dconf write ${KEYS_POP}/tile-resize-right "['<Primary>Right', '<Primary>l']" 
dconf write ${KEYS_POP}/tile-resize-up    "['<Primary>Up', '<Primary>k']"       
dconf write ${KEYS_POP}/tile-resize-down  "['<Primary>Down', '<Primary>j']"   

# select tiles
dconf write ${KEYS_POP}/tile-swap-left   "['Left', 'h']"   
dconf write ${KEYS_POP}/tile-swap-right  "['Right', 'l']" 
dconf write ${KEYS_POP}/tile-swap-up     "['Up', 'k']"       
dconf write ${KEYS_POP}/tile-swap-down   "['Down', 'j']"   

# show overview
dconf write ${KEYS_GNOME_WM}/toggle-overview "['<Super>d']"

# logout
dconf write ${KEYS_MEDIA}/logout "['<Shift><Super>q']"

# close Window
dconf write ${KEYS_GNOME_WM}/close "['<Super>q']"

# hide titles
dconf write ${KEYS_POP}/show-title "false"

# disable pop shell launcher
dconf write ${KEYS_POP}/activate-launcher "@as []"
