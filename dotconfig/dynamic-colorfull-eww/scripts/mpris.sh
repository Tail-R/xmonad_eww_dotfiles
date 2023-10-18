#!/bin/bash

######################################################################
## You need to install playerctl
######################################################################
get_music_title() {
    if [ "$(playerctl status)" == "Playing" ]; then
        echo $(playerctl metadata --format '{{title}}')
    else
        echo "offline"
    fi
}

get_music_artist() {
    if [ "$(playerctl status)" == "Playing" ]; then
        echo $(playerctl metadata --format '{{artist}}')
    else
        echo "unknown"
    fi
}

get_music_cover() {
    playerStatus=$(playerctl -l --no-messages)

    # Firefox founded
    if [ "${playerStatus:0:7}" == "firefox" ]; then
        path="$HOME/.mozilla/firefox/firefox-mpris/"
        image="$(ls $path)"
    
        echo "$path$image"
        return 
    
    # Spotify founded
    elif [ "$playerStatus" == "spotify" ]; then
        echo $(playerctl metadata | grep artUrl | awk '{print $3}')
        return
    fi
}

get_music_status() {
    status=$(playerctl status --no-messages)

    if [ "$status" == "Playing" ]; then
        echo "playing"
    else
        echo ""
    fi
}

# Main
case "$1" in
    "--title"       ) get_music_title ;;
    "--artist"      ) get_music_artist ;;
    "--cover"       ) get_music_cover ;;
    "--status"      ) get_music_status ;;
    "--toggle"      ) playerctl play-pause --no-messages ;;
    "--next"        ) playerctl next --no-messages ;;
    "--prev"        ) playerctl previous --no-messages ;;
esac






