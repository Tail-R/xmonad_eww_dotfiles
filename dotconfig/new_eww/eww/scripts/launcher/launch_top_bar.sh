#!/bin/bash

ewwPath="$HOME/.config/eww"
tmpPath="$HOME/.cache/eww/top_bar"

if [ ! -d $HOME/.cache/eww ]; then
    mkdir $HOME/.cache/eww;
fi

windows="
            window_top_bar
        "

toggle() {
    if [ -f $tmpPath ]; then
        rm $tmpPath
        eww -c $ewwPath close $windows
    else
        touch $tmpPath
        eww -c $ewwPath open-many $windows
    fi
}

# Main
if [ "$1" == "--open_all" ]; then
    touch $tmpPath
    eww -c $ewwPath open-many $windows 
elif [ "$1" == "--toggle" ]; then
    toggle
fi









