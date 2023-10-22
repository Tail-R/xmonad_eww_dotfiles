#!/bin/bash

######################################################################
## You must run this script once before using eww to activate all
## features.
######################################################################

ewwPath="$HOME/.config/eww"
cd $ewwPath

# Main
# start virtual desktops thumbnails daemon
if [ ! -d $ewwPath/scripts/vdesk_viewer/thumbnails ]; then
    mkdir $ewwPath/scripts/vdesk_viewer/thumbnails
else
    rm -f $ewwPath/scripts/vdesk_viewer/thumbnails/*
fi

# Clear log.txt
if [ ! -f $ewwPath/scripts/vdesk_viewer/log.txt ]; then
    touch $ewwpath/scripts/vdesk_viewer/log.txt
else
    echo "" > $ewwPath/scripts/vdesk_viewer/log.txt
fi

$ewwPath/scripts/launcher/launch_left_widget.sh --open &
$ewwPath/scripts/launcher/launch_right_mplayer.sh --open &
$ewwPath/scripts/vdesk_viewer/./main.py &

