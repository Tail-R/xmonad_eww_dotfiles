#!/bin/bash

ewwPath="$HOME/.config/eww"
tmpPath="$HOME/.cache/eww/right_mplayer"
v0="SHOW_RIGHT_MPLAYER"

if [ ! -d $HOME/.cache/eww ]; then
    mkdir $HOME/.cache/eww;
fi

windows="window_right_mplayer"

toggle() {
    if [ -f $tmpPath ]; then
        rm $tmpPath
        eww -c $ewwPath close $windows
        eww -c $ewwPath update $v0=false
    else
        touch $tmpPath
        eww -c $ewwPath open-many $windows
        eww -c $ewwPath update $v0=true
    fi
}

# Main
if [ "$1" == "--open_all" ]; then
    touch $tmpPath
    eww -c $ewwPath open-many $windows 
    eww -c $ewwPath update $v0=true
elif [ "$1" == "--toggle" ]; then
    toggle
fi









