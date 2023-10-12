#!/bin/bash

ewwPath="$HOME/.config/eww"
v0="SHOW_LEFT_WIDGET"
v1="SHOW_CALENDAR"
v2="HOVER_BLUETOOTH"
v3="SHOW_BLUETOOTH"
v4="HOVER_LAN"
v5="SHOW_LAN"

case "$1" in
    "--rev_rev_switcher" )
        eww -c $ewwPath update 
        ;;
    
    "--rev_page0" )
        ;;
    
    "--rev_page1" )
        ;;
    
    "--rev_page2" )
        ;;
esac

