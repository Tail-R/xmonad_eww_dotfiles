#!/bin/bash

ewwPath="$HOME/.config/eww"

v0="SHOW_CENTER_DMENU_PAGE0"
v1="SHOW_CENTER_DMENU_PAGE1"

case "$1" in 
    "--rev_page0" )
        eww -c $ewwPath update $v0=true $v1=false
        ;;
    
    "--rev_page1" )
        eww -c $ewwPath update $v0=false $v1=true
        ;;
esac

