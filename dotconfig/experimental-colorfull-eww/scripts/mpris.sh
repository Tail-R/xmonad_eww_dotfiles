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
    playerctl --follow metadata | while read -r metadata; do

    if [ "$(playerctl -l | grep 'firefox')" != "" ]; then
        echo $(echo $metadata | grep "mpris:artUrl" | sed -e 's/.*file:\/\///g')
    fi
done

    # # Firefox founded
    # if [ "${playerStatus:0:7}" == "firefox" ]; then
    #     playerctl --follow metadata | while read -r metadata; do
    #         artUrl=$(echo $metadata | grep "mpris:artUrl" | sed -e 's/.*file:\/\///g')
    #         echo $artUrl

    #     done

    # # Spotify founded
    # elif [ "$playerStatus" == "spotify" ]; then
    #     playerctl --follow metadata | while read -r metadata; do
    #         artUrl=$(echo $metadata | grep "mpris:artUrl" | awk '{print $3}')
    #         echo $artUrl
    #     done
    # fi
}

get_music_status() {
    status=$(playerctl status --no-messages)

    if [ "$status" == "Playing" ]; then
        echo "playing"
    else
        echo ""
    fi
}

get_music_player_name() {
    player=$(playerctl -l --no-messages | awk 'NR == 1 {print $1}')

    if [ "${player:0:7}" == "firefox" ]; then
        echo "Firefox"
    elif [ "$player" == "spotify" ]; then
        echo "Spotify"
    fi
}

get_music_player_icon() {
    player=$(playerctl -l --no-messages | awk 'NR == 1 {print $1}')
    
    if [ "${player:0:7}" == "firefox" ]; then
        echo "󰈹"
    elif [ "$player" == "spotify" ]; then
        echo "󰓇"
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
    "--player_name" ) get_music_player_name ;;
    "--player_icon" ) get_music_player_icon ;;
esac






