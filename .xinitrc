#
#   ██╗  ██╗██╗███╗   ██╗██╗████████╗██████╗  ██████╗
#   ╚██╗██╔╝██║████╗  ██║██║╚══██╔══╝██╔══██╗██╔════╝
#    ╚███╔╝ ██║██╔██╗ ██║██║   ██║   ██████╔╝██║
#    ██╔██╗ ██║██║╚██╗██║██║   ██║   ██╔══██╗██║
#██╗██╔╝ ██╗██║██║ ╚████║██║   ██║   ██║  ██║╚██████╗
#╚═╝╚═╝  ╚═╝╚═╝╚═╝  ╚═══╝╚═╝   ╚═╝   ╚═╝  ╚═╝ ╚═════╝
#

# Starts my equalizer
pulseaudio-equalizer enable &


# Launches programs
exec slstatus &
exec alacritty &
exec qutebrowser &

# Allows for faster output when holding down a key, very useful for vim
exec xset r rate 225 75 &

# Sets default browser
exec xdg-settings set default-web-browser org.qutebrowser.qutebrowser.desktop &

# Sets the sensitivity of my mouse
exec xinput --set-prop "pointer:Logitech MX Master 2S" "Coordinate Transformation Matrix" 0.5 0 0 0 0.5 0 0 0 1 &

# Sets up my dual monitor setup
xrandr --output DVI-D-0 --off --output HDMI-0 --off --output DP-0 --off --output DP-1 --off --output DP-2 --mode 1920x1080 --pos 1920x0 --rotate right --output DP-3 --off --output DP-4 --primary --mode 1920x1080 --pos 0x369 --rotate normal --output DP-5 --off &

# I am too lazy to setup ntpd
doas hwclock --systohc

# doas macchanger -r enp5s0

# Launches DWM
exec dwm

