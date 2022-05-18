#!/bin/bash
echo Welcome $USER
echo Sit back and relax while your system is being setup.
# git clone https://github.com/ColexDev/dotfiles
# cd dotfiles
sudo xbps-install -Syf opendoas

# WE DON'T WANT BLOAT
echo Time to remove the BLOAT :pray:
doas xbps-remove -Rfy sudo

# Install all programs
doas xbps-install -Syf $(cat installed_packages)
sleep 1

# Install Spotify
echo Would you like to install spotify? [WARNING: IT IS NON FREE SOFTWARE] (y/n)
read CHOICE
if [CHOICE == "y"]
then
    git clone https://github.com/void-linux/void-packages.git
    cd void-packages
    ./xbps-src binary-bootstrap
    ./xbps-src pkg spotify
    echo XBPS_ALLOW_RESTRICTED=yes >> etc/conf
    xi -Sfy spotify
    cd
    doas rm -rf void-packages
    sleep 1
fi

rm -f README.md

# Move folders where they need to go
mv scripts $HOME
mv repos $HOME
mv .config $HOME
mv .bashrc $HOME
mv .inputrc $HOME
mv .xinitrc $HOME
cd

# Install suckless programs
cd repos
cd dmenu
sudo make clean install
cd ..
cd dwm
sudo make clean install
cd ..
cd slstatus
sudo make clean install

cd

$CHOICE = "n"
echo Enjoy your system $USER, Would you like to reboot now (y/n)
read CHOICE
if [CHOICE == "y"]
then
    doas reboot
fi
