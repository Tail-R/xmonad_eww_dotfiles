#!/bin/bash

ewwPath="$HOME/.config/eww"
vIndex="INDEX_RICESET_CURR"
v0="COLOR_RICESET_CURR_FG"
v1="COLOR_RICESET_CURR_PR"


get_fg() {
    index=$(eww -c $ewwPath get $vIndex)
    cat ~/.config/eww/scss/colors/$(eww -c $ewwPath get JSON_RICESET | jq ".[$index].scss_name" | sed -e 's/"//g').scss | grep \$fg: | awk '{print $2}' | sed -e 's/#//g' -e 's/;//g'
}

get_primary() {
    index=$(eww -c $ewwPath get $vIndex)
    cat ~/.config/eww/scss/colors/$(eww -c $ewwPath get JSON_RICESET | jq ".[$index].scss_name" | sed -e 's/"//g').scss | grep \$primary: | awk '{print $2}' | sed -e 's/#//g' -e 's/;//g'
}

update_fg() {
    fg=$(get_fg)
    eww -c $ewwPath update $v0="$fg"
}

update_primary() {
    primary=$(get_primary)
    eww -c $ewwPath update $v1="$primary"
}

# Main
if [ "$1" == "--get_fg" ]; then
    get_fg
elif [ "$1" == "--get_primary" ]; then
    get_primary
elif [ "$1" == "--update_fg" ]; then
    update_fg
elif [ "$1" == "--update_primary" ]; then
    update_primary
elif [ "$1" == "--update_all" ]; then
    $(update_fg)
    $(update_primary)
fi



