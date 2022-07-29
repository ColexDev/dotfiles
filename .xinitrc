#
#   ██╗  ██╗██╗███╗   ██╗██╗████████╗██████╗  ██████╗
#   ╚██╗██╔╝██║████╗  ██║██║╚══██╔══╝██╔══██╗██╔════╝
#    ╚███╔╝ ██║██╔██╗ ██║██║   ██║   ██████╔╝██║
#    ██╔██╗ ██║██║╚██╗██║██║   ██║   ██╔══██╗██║
#██╗██╔╝ ██╗██║██║ ╚████║██║   ██║   ██║  ██║╚██████╗
#╚═╝╚═╝  ╚═╝╚═╝╚═╝  ╚═══╝╚═╝   ╚═╝   ╚═╝  ╚═╝ ╚═════╝
#
# Launches programs
exec slstatus &
exec alacritty &
exec chromium &
exec qutebrowser &

# Allows for faster output when holding down a key
exec xset r rate 225 75 &

# Sets default browser
# exec xdg-settings set default-web-browser org.qutebrowser.qutebrowser.desktop &
exec xdg-settings set default-web-browser chromium.desktop &

# Sets the sensitivity of my mouse
exec xinput --set-prop "pointer:Logitech MX Master 2S" "Coordinate Transformation Matrix" 0.5 0 0 0 0.5 0 0 0 1 &

# Sets up my dual monitor setup
xrandr --output DP-2 --mode 1920x1080 --pos 1920x0 --rotate right --output DP-4 --primary --mode 1920x1080 --pos 0x369 --rotate normal &

# Sets the correct time (too lazy to setup ntpd)
doas hwclock --systohc

# Launches dwm
exec dwm
