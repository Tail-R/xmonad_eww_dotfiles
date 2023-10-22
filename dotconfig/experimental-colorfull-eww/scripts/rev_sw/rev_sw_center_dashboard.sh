#!/bin/bash

ewwPath="$HOME/.config/eww"

v0="SHOW_CENTER_DASHBOARD_PAGE0"
v1="SHOW_CENTER_DASHBOARD_PAGE1"
v2="SHOW_CENTER_DASHBOARD_PAGE2"

case "$1" in 
    "--rev_page0" )
        eww -c $ewwPath update $v0=true $v1=false $v2=false
        ;;
    
    "--rev_page1" )
        eww -c $ewwPath update $v0=false $v1=true $v2=false
        ;;
    
    "--rev_page2" )
        eww -c $ewwPath update $v0=false $v1=false $v2=true
        ;;
esac

