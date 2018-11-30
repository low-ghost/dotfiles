#!/bin/env sh

pkill polybar

sleep 1;

INDEX=0
PREV_MONITOR=""
ALL_MONITORS=""

for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
  if [ "$INDEX" -eq "0" ]; then
    xrandr --output $m --auto
  else
    xrandr --output $m --auto --right-of $PREV_MONITOR
  fi

  MONITOR=$m polybar i3wmthemer_bar &

  PREV_MONITOR=$m
  ALL_MONITORS="$ALL_MONITORS $m"
  INDEX=$((INDEX+1))
done

nitrogen --restore
notify-send "Connected monitors:$ALL_MONITORS"
