#!/bin/bash

ewwPath="$HOME/.config/eww/bar"
tmpPath="$HOME/.cache/eww/bar"

windows="
            window_bg
            window_start
            window_workspace
            window_activewindow
            window_music 
            
            window_sysinfo 
            window_battery
            window_clock
            window_power

            window_workspace_secondary
            window_clock_secondary
            window_battery_secondary 
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

if [ "$1" == "--open-all" ]; then
    touch $tmpPath
    eww -c $ewwPath open-many $windows
elif [ "$1" == "--toggle" ]; then
    toggle
fi







