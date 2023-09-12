#!/bin/bash

if [ ! -d $HOME/.cache/eww ]; then
   mkdir ~/.cache/eww
fi 

ewwPath="$HOME/.config/eww/minimal-bar"
tmpPath="$HOME/.cache/eww/minimal-bar"

windows="
            window_workspace
            window_music 
            window_battery
            window_clock
        "

toggle() {
    if [ -f $tmpPath ]; then
        rm $tmpPath
        eww -c $ewwPath close-all
    else 
        touch $tmpPath
        eww -c $ewwPath open-many $windows
    fi
}

# Main
if [ "$1" == "--open-all" ]; then
    touch $tmpPath
    eww -c $ewwPath open-many $windows 
elif [ "$1" == "--toggle" ]; then
    toggle
fi 




