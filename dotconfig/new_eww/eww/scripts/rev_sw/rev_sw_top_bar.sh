#!/bin/bash

ewwPath="$HOME/.config/eww"
vs="SHOW_BAR_CENTER_REV_SW"
v0="SHOW_BAR_CENTER_PAGE0"
v1="SHOW_BAR_CENTER_PAGE1"
v2="SHOW_BAR_CENTER_PAGE2"

case "$1" in
    "--rev_rev_switcher" )
        eww -c $ewwPath update $vs=true $v0=false $v1=false $v2=false
        ;;
    
    "--rev_page0" )
        eww -c $ewwPath update $vs=false $v0=true $v1=false $v2=false
        ;;
    
    "--rev_page1" )
        eww -c $ewwPath update $vs=false $v0=false $v1=true $v2=false
        ;;
    
    "--rev_page2" )
        eww -c $ewwPath update $vs=false $v0=false $v1=false $v2=true
        ;;
esac

