#!/bin/sh

xrdb ~/.Xresources

xinput --set-prop "Cypress APA Trackpad (cyapa)" "Device Accel Constant Deceleration" 1.5

/usr/bin/tint2 -c ~/.tint2rc &
(sleep 4s && parcellite) &
(sleep 10s && xscreensaver -no-splash) &

exec xmonad
