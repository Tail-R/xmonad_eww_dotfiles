#!/bin/bash

ewwPath="$HOME/.config/eww/popup"
tmpPath="$HOME/.cache/eww/popup"

if [ ! -d $HOME/.cache/eww ]; then
   mkdir ~/.cache/eww
fi 
    
if [ ! -d $tmpPath ]; then
    mkdir $tmpPath;
fi

toggle() {
    if [ -f $tmpPath/"$1" ]; then
        rm $tmpPath/"$1"

        eww -c $ewwPath close $1

        # reset animation
        eww -c $ewwPath update GNOME_WIDGET_SHOW=false
    else
        touch $tmpPath/"$1"
        
        eww -c $ewwPath open $1 
        
        # start animation
        eww -c $ewwPath update GNOME_WIDGET_SHOW=true
        
        $ewwPath/scripts/bluetooth.sh --update_eww_json
        $ewwPath/scripts/network.sh --update_eww_json
    fi
}

# Main
if [ "$1" == "--toggle_gnome_widget" ]; then
    toggle window_gnome_widget
elif [ "$1" == "--toggle_music" ]; then
    toggle window_music
elif [ "$1" == "--toggle_powermenu" ]; then
    toggle window_powermenu
elif [ "$1" == "--toggle_ssmenu" ]; then
    toggle window_ssmenu
fi







