#!/bin/bash
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

get_music_art() {
    playerStatus=$(playerctl -l)

    # Spotify founded
    if [ "$playerStatus" == "spotify" ]; then
        echo $(playerctl metadata | grep artUrl | awk '{print $3}')
        return
    
    # Firefox founded
    elif [ "${playerStatus:0:7}" == "firefox" ]; then
        path="$HOME/.mozilla/firefox/firefox-mpris/"
        image="$(ls $path)"
    
        echo "$path$image"
        return 
    fi 
}

# Main
case "$1" in
    "--title"       ) get_music_title ;;
    "--artist"      ) get_music_artist ;;
    "--art"         ) get_music_art ;;
esac






