# Launches programs
exec slstatus &
exec alacritty &
exec qutebrowser &
exec pulseaudio-equalizer enable &
exec discord &

# Sets wallpaper
exec ~/Scripts/.fehbg &

# Allows for faster output when holding down a key, very useful for vim
exec xset r rate 225 75 &

# Sets default browser
exec xdg-settings set default-web-browser org.qutebrowser.qutebrowser.desktop &

# Mounts my drives if plugged in
exec sudo mount UUID=f23b86c3-63ac-4e21-91f6-123d74cd557b /home/cole/flashDrive/ &
exec sudo mount UUID=3583DD0C22E7BC7A /home/cole/SSD/ &

# This sets the screen to stay on all the time (I think)
# exec xset -dpms &

# Sets the sensitivity of my mouse
exec xinput --set-prop "pointer:Logitech MX Master 2S" "Coordinate Transformation Matrix" 0.5 0 0 0 0.5 0 0 0 1 &

# Sets up my dual monitor setup
exec xrandr --output DVI-D-0 --off --output HDMI-0 --off --output DP-0 --off --output DP-1 --off --output DP-2 --mode 1920x1080 --rate 75 --pos 1920x0 --rotate right --output DP-3 --off --output DP-4 --primary --mode 1920x1080 --rate 144 --pos 0x379 --rotate normal --output DP-5 --off &

# Launches DWM
exec dbus-launch dwm
