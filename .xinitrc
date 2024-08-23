# Starts status bar
exec slstatus &

# Allows for faster output when holding down a key
exec xset r rate 225 75 &

# Enables equalizer
pulseaudio-equalizer enable &

# Sets default browser
exec xdg-settings set default-web-browser firefox.desktop &

# Sets the sensitivity of my mouse
# NOTE: This mouse has weird behavior for some stuff, use g502 for kicad and others
exec xinput --set-prop "pointer:Logitech MX Master 2S" "Coordinate Transformation Matrix" 0.5 0 0 0 0.5 0 0 0 1 &

xbanish -t 2 &

# Sets up my dual monitor setup (only using one monitor now)
# xrandr --output DP-2 --mode 1920x1080 --pos 1920x0 --rotate right --output DP-4 --primary --mode 1920x1080 --pos 0x369 --rotate normal &

# Sets the correct time (too lazy to setup ntpd)
# doas hwclock --systohc
doas ntpdate ntp.ubuntu.com &

# Launches dwm
exec dwm
