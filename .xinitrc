exec slstatus &
exec xrandr --output DVI-D-1 --off --output DP-1 --rate 75 --mode 1920x1080 --pos 0x0 --rotate left --output DP-2 --rate 144 --primary --mode 1920x1080 --pos 1080x376 --rotate normal --output HDMI-1 --off --output DP-3 --rate 75 --mode 1920x1080 --pos 3000x0 --rotate right &
exec st &
exec firefox &
exec discord &
exec mount /dev/sdc1 /run/media/cole/7878-A26C &
exec xset r rate 300 50 &
setxkbmap -option caps:swapescape &
exec dbus-launch dwm

