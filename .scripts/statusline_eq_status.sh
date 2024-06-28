output=$(pulseaudio-equalizer status | grep 'Equalizer status' | awk -F'[][]' '{print $2}')

if [ $output = "enabled" ];
then
    echo ON
else
    echo OFF
fi
