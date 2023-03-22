#!/usr/bin/env bash 

lxsession &
/usr/bin/emacs --daemon &
nitrogen --restore &
volumeicon &
#nm-applet &
nm-tray &

### UNCOMMENT ONLY ONE OF THE FOLLOWING THREE OPTIONS! ###
# 1. Uncomment to restore last saved wallpaper
#xargs xwallpaper --stretch < ~/.xwallpaper &
# 2. Uncomment to set a random wallpaper on login
# find /usr/share/backgrounds/dtos-backgrounds/ -type f | shuf -n 1 | xargs xwallpaper --stretch &
# 3. Uncomment to set wallpaper with nitrogen
