#!/bin/bash

ewwPath="$HOME/.config/eww"
v0="JSON_RICESET"

if [[ -d $ewwPath/scripts/rice_changer/json && -f $ewwPath/scripts/rice_changer/json/riceset.json ]]; then
    json=$(cat $ewwPath/scripts/rice_changer/json/riceset.json)
    eww -c $ewwPath update $v0="$json"
fi


