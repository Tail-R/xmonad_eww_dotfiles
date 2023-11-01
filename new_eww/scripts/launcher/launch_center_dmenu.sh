#!/bin/bash

ewwPath="$HOME/.config/eww"
tmpPath="$HOME/.cache/eww/center_dmenu"
v0="SHOW_CENTER_DMENU"

if [ ! -d $HOME/.cache/eww ]; then
    mkdir $HOME/.cache/eww;
fi

window="window_center_dmenu"

toggle() {
    if [ -f $tmpPath ]; then
        rm $tmpPath
        eww -c $ewwPath close $window
        eww -c $ewwPath update $v0=false
    else
        touch $tmpPath
        $ewwPath/scripts/desktop_apps/./manage_apps.py --update_eww
        eww -c $ewwPath open-many $window
        eww -c $ewwPath update $v0=true
    fi
}

# Main
if [ "$1" == "--open" ]; then
    touch $tmpPath
    $ewwPath/scripts/desktop_apps/./manage_apps.py --update_eww
    eww -c $ewwPath open-many $window
    eww -c $ewwPath update $v0=true
elif [ "$1" == "--toggle" ]; then
    toggle
elif [ "$1" == "--close" ]; then
    rm $tmpPath
    eww -c $ewwPath close $window
    eww -c $ewwPath update $v0=false
fi









