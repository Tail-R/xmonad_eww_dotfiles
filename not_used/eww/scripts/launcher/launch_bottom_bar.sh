#!/bin/bash

ewwPath="$HOME/.config/eww"
tmpPath="$HOME/.cache/eww/bottom_bar"

window="window_bottom_bar"

v0="SHOW_RIGHT_MPLAYER"

if [ ! -d $HOME/.cache/eww ]; then
    mkdir $HOME/.cache/eww;
fi

toggle() {
    if [ -f $tmpPath ]; then
        rm $tmpPath
        eww -c $ewwPath close $window
        eww -c $ewwPath update $v0=false
    else
        touch $tmpPath
        eww -c $ewwPath open-many $window
        eww -c $ewwPath update $v0=true
    fi
}

# Main
if [ "$1" == "--open" ]; then
    touch $tmpPath
    eww -c $ewwPath open-many $window
    eww -c $ewwPath update $v0=true
elif [ "$1" == "--toggle" ]; then
    toggle
fi









