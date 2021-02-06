#!/usr/bin/env sh

xautolock -detectsleep -corners 0-00 -time 5 \
  -locker "slock" \
  -notify 30 \
  -notifier "notify-send -u critical -t 10000 'Locking screen in 30 seconds'" &

# set wallpaper
xwallpaper --zoom "${XDG_DATA_HOME:-$HOME/.local/share}/dwm/wallpaper.png" &

# use caps as super
setxkbmap -option 'caps:super' &

# tap caps for escape (hold down for super)
xcape -e 'Super_L=Escape' &

# activate num lock
numlockx &

# configure monitors
$HOME/.local/bin/configure-monitors &

xsetroot -name " $(date +"%a %d %b, %H:%M")" &
dwmblocks &
