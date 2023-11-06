#!/bin/bash

ewwPath="$HOME/.config/eww"
tmpPath="$HOME/.cache/eww/top_bar"

window="window_top_bar"

if [ ! -d $HOME/.cache/eww ]; then
    mkdir $HOME/.cache/eww;
fi

toggle() {
    if [ -f $tmpPath ]; then
        rm $tmpPath
        eww -c $ewwPath close $window
    else
        touch $tmpPath
        eww -c $ewwPath open-many $window
    fi
}

# Main
if [ "$1" == "--open" ]; then
    touch $tmpPath
    eww -c $ewwPath open-many $window 
elif [ "$1" == "--toggle" ]; then
    toggle
fi









