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
        echo "true"
    else
        echo "false"
    fi
}

music_toggle() {
    playerctl play-pause
}

music_next() {
    playerctl next --no-messages
}

music_prev() {
    playerctl previous --no-messages
}

get_music_position() {
    if [ "$(playerctl status --no-messages)" == "Playing" ]; then
        length=$((`playerctl metadata | grep length | awk '{print $3}'` / 1000000))
        position=$(playerctl position | awk '{printf("%d\n", $1)}')
        echo $((100 * $position / $length ))
        return
    fi
    
    echo 0
}

loop_toggle() {
    if [ "$(playerctl loop)" == "Playlist" ]; then
        playerctl loop track
    else
        playerctl loop playlist
    fi
}

get_loop_status() {
    if [ "$(playerctl loop)" == "Playlist" ]; then
        echo "false"
    else
        echo "true"
    fi
} 

# Main
case "$1" in
    "--title"       ) get_music_title ;;
    "--artist"      ) get_music_artist ;;
    "--art"         ) get_music_cover ;;
    "--status"      ) get_music_status ;;
    "--toggle"      ) music_toggle ;;
    "--next"        ) music_next ;;
    "--prev"        ) music_prev ;;
    "--position"    ) get_music_position ;;
    "--loop"        ) loop_toggle ;;
    "--loop_status" ) get_loop_status ;;
esac






