#!/bin/bash

ewwPath="$HOME/.config/eww/popup"
tmpPath="$HOME/.cache/eww/popup"

windows="
            window_gnome_widget
            window_music
            window_powermenu
            window_ssmenu 
        "

toggle() {
    if [ -f $tmpPath/"$1" ]; then
        rm $tmpPath/"$1"
        eww -c $ewwPath close $1
    else
        touch $tmpPath/"$1"
        eww -c $ewwPath open $1
    fi
}

# Main
if [ "$1" == "--open-all" ]; then
    touch $tmpPath
    eww -c $ewwPath open-many $windows
elif [ "$1" == "--toggle_gnome_widget" ]; then
    toggle window_gnome_widget
elif [ "$1" == "--toggle_music" ]; then
    toggle window_music
elif [ "$1" == "--toggle_powermenu" ]; then
    toggle window_powermenu
elif [ "$1" == "--toggle_ssmenu" ]; then
    toggle window_ssmenu
fi







