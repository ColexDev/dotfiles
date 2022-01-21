#!/bin/sh

xrandr --output DVI-D-0 --off --output HDMI-0 --off --output DP-0 --off --output DP-1 --off --output DP-2 --mode 1920x1080 --pos 1920x0 --rotate right --output DP-3 --off --output DP-4 --primary --mode 1920x1080 --pos 0x369 --rotate normal --output DP-5 --off
doas ntpdate ntp.ubuntu.com

pulseaudio-equalizer enable
