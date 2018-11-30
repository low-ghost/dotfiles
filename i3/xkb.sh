#!/bin/env sh

pkill xcape > /dev/null
rm -f /var/lib/xkb/*.xk
setxkbmap -layout nc
sh ~/.xcaperc
