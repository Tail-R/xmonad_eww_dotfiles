#!/bin/bash

ewwPath="$HOME/.config/eww"
tmpPath="$HOME/.cache/eww/center_dashboard"
v0="SHOW_CENTER_DASHBOARD"

if [ ! -d $HOME/.cache/eww ]; then
    mkdir $HOME/.cache/eww;
fi

windows="window_center_dashboard"

toggle() {
    if [ -f $tmpPath ]; then
        rm $tmpPath
        eww -c $ewwPath close $windows
        eww -c $ewwPath update $v0=false
    else
        touch $tmpPath
        eww -c $ewwPath open-many $windows
        sleep 0.2
        eww -c $ewwPath update $v0=true
    fi
}

# Main
if [ "$1" == "--open" ]; then
    touch $tmpPath
    eww -c $ewwPath open-many $windows 
    sleep 0.2
    eww -c $ewwPath update $v0=true
elif [ "$1" == "--toggle" ]; then
    toggle
fi









