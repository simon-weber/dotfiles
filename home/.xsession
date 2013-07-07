#!/bin/sh

/usr/bin/tint2 -c ~/.tint2rc &
feh --bg-center /home/simon/images/wallpapers/darkwood.jpg &
(sleep 1s && nm-applet) &
(sleep 2s && xfce4-power-manager) &
(sleep 3s && parcellite) &
(sleep 3s && volumeicon) &
(sleep 15s && xscreensaver -no-splash) &
(sleep 15s && ~/.dropbox-dist/dropboxd) &

exec xmonad
