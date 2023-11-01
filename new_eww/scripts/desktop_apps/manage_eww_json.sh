#!/bin/bash

######################################################################
## You need to install jq command
######################################################################

ewwPath="$HOME/.config/eww"
v0="JSON_DESKTOP_APPS"

cd $ewwPath/scripts/desktop_apps

json_regex_match() {
    res=[$(echo $(eww -c $ewwPath get JSON_DESKTOP_APPS | \
        jq '.[] | select(.disp_name | test("'$1'"))') \
        | sed -e 's/} /},/g')]
    
    eww -c $ewwPath update $v0="$res"
}

# Main
if [ "$1" == "--regex_match" ]; then
    ./manage_apps.py --update_eww
    json_regex_match $2
elif [ "$1" == "--asc_order" ]; then
    res=$(eww -c $ewwPath get JSON_DESKTOP_APPS | jq ". | sort_by(.disp_name)")
    
    eww -c $ewwPath update $v0="$res"
elif [ "$1" == "--des_order" ]; then
    res=$(eww -c $ewwPath get JSON_DESKTOP_APPS | jq ". | sort_by(.disp_name) | reverse")
    
    eww -c $ewwPath update $v0="$res"
elif [ "$1" == "--reverse" ]; then
    echo 1
fi


