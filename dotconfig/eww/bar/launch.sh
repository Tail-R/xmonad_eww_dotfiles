#!/bin/bash

ewwPath="$HOME/.config/eww/bar"
tmpPath="$HOME/.cache/eww/bar"

if [ ! -d $HOME/.cache/eww ]; then
   mkdir ~/.cache/eww
fi 

windows="
            window_bg
            window_start
            window_workspace
            window_activewindow
            window_music 
            
            window_sysinfo 
            window_battery
            window_clock
            window_menu
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







