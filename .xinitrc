exec xscreensaver &
exec slstatus &
exec xrandr --output DVI-D-0 --off --output HDMI-0 --off --output DP-0 --mode 1920x1080 --rate 75 --pos 3000x0 --rotate right --output DP-1 --off --output DP-2 --mode 1920x1080 --rate 75 --pos 0x0 --rotate left --output DP-3 --off --output DP-4 --primary --mode 1920x1080 --rate 144 --pos 1080x420 --rotate normal --output DP-5 --off &
exec alacritty &
exec qutebrowser &
exec lightcord &
exec xset r rate 225 75 &
exec xdg-settings set default-web-browser org.qutebrowser.qutebrowser.desktop &
exec sudo mount UUID=f23b86c3-63ac-4e21-91f6-123d74cd557b /home/cole/flashDrive/ &
exec sudo mount UUID=3583DD0C22E7BC7A /home/cole/SSD/ &
exec xset -dpms &
exec dbus-launch dwm
