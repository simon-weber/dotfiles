#!/bin/sh

/usr/bin/tint2 -c ~/.tint2rc &
(sleep 4s && parcellite) &
(sleep 10s && xscreensaver -no-splash) &

exec xmonad
