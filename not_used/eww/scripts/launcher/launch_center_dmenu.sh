#!/bin/bash

ewwPath="$HOME/.config/eww"
tmpPath="$HOME/.cache/eww/center_dmenu"

window="window_center_dmenu"

close0="$ewwPath/scripts/launcher/launch_left_widget_v2.sh --close &"
close1="$ewwPath/scripts/launcher/launch_right_mplayer.sh --close &"

duration=0.2

if [ ! -d $HOME/.cache/eww ]; then
    mkdir $HOME/.cache/eww;
fi

toggle() {
    if [ -f $tmpPath ]; then
        rm $tmpPath
        eww -c $ewwPath close $window
    else
        touch $tmpPath

        $close0
        $close1

        sleep $duration

        $ewwPath/scripts/desktop_apps/./manage_apps.py --update_eww
        eww -c $ewwPath open-many $window
    fi
}

# Main
if [ "$1" == "--open" ]; then
    touch $tmpPath
    $ewwPath/scripts/desktop_apps/./manage_apps.py --update_eww 
    eww -c $ewwPath open-many $window
elif [ "$1" == "--toggle" ]; then
    toggle
elif [ "$1" == "--close" ]; then
    rm -f $tmpPath
    eww -c $ewwPath close $window
fi









