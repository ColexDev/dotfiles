output=$(pulseaudio-equalizer status | grep 'Equalizer status' | awk -F'[][]' '{print $2}')

if [ $output = "enabled" ];
then
    echo on
else
    echo off
fi
