#!/bin/bash

######################################################################
## You need to install xprop
######################################################################

ewwPath="$HOME/.config/eww"

v0="ANIM_TOP_BAR"

duration=0.2

# Main
xprop -spy -root _NET_CURRENT_DESKTOP | while read -r; do
    eww -c $ewwPath update $v0=false
    sleep $duration
    eww -c $ewwPath update $v0=true
done

