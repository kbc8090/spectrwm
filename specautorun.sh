#!/bin/sh

xrandr -s 1920x1200 &
xset r rate 300 60 &
#$HOME/.local/bin/wallpaper &
nitrogen --restore &
picom &
#/home/kbc/.config/polybar/launch.sh &
