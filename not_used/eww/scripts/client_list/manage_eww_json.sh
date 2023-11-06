#!/bin/bash

ewwPath="$HOME/.config/eww"
v0="JSON_DOCK_CLIENT_LIST"

cd $ewwPath/scripts/client_list

# Main
xprop -spy -root _NET_CLIENT_LIST | while read -r; do
    res=$(./client_list.py | jq ". | sort_by(.icon_path)")
    # eww -c $ewwPath update $v0="$res"
    echo $res
done
