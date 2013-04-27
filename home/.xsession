#!/bin/sh

/usr/bin/tint2 -c ~/.tint2rc &
xbindkeys &
feh --bg-center ~/images/wallpapers/darkwood.jpg &
nm-applet &
xfce4-power-manager &
(sleep 4s && volumeicon) &
(sleep 4s && parcellite) &
(sleep 10s && xscreensaver -no-splash) &
(sleep 10s && ~/.dropbox-dist/dropboxd) &

exec xmonad
