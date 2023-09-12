#!/bin/bash

# Get the path to image of the song
get_art() {
    playerStatus="$(playerctl -l --no-messages)"

    # No players found
    if [ "${#playerStatus}" = "0" ]; then
	echo "$HOME/Pictures/50goto/50goto12.jpg"
	return

    # Found Spotify
    elif [ "$playerStatus" = "spotify" ]; then 
	echo "$(playerctl metadata | grep artUrl | awk '{print $3}')"
	return

    # Found Firefox
    elif [ "${playerStatus:0:7}" = "firefox" ];then
    	header="$HOME/.mozilla/firefox/firefox-mpris/"
    	imageName="$(ls $header)"

    	echo "$header$imageName"
	#echo "$HOME/Pictures/goto/goto7.jpg"
    	return
    fi
}

# Get artist's name of the song
get_artist() {
    artist=$(timeout 0.1s playerctl --follow metadata --format '{{artist}}')

    if [ "$artist" = "" ]; then
	echo "unknown"
	return
    fi

    echo "${artist}"
}

# Get title of the song
get_title() {
    title=$(timeout 0.1s playerctl --follow metadata --format '{{title}}')

    if [ "$title" = "" ]; then
	echo "mpris-player"
	return
    fi	

    echo "${title}"
}

# Toggle play and pause
toggle() {
    status=$(playerctl status --no-messages)

    if [ "$status" = "Playing" ]; then
	playerctl pause
    else
	playerctl play
    fi
}

# Get Status of the player
get_status() {
    status=$(playerctl status --no-messages)
    
    if [ "$status" = "Playing" ]; then
	echo "1"
    else
	echo "0"
    fi
}

# Get the position of the song
get_position() {
    status=$(playerctl status --no-messages)
    
    if [ "$status" = "Playing" ]; then
	length=$(playerctl metadata | grep length | awk '{print $3}' | cut -c 1-3)
	position=$(playerctl position | awk '{printf("%d\n",$1)}')

	echo $((100 * $position / length))
	return
    fi

    echo 0
}

# Check the argument and call the function
if [ "$1" = "--art" ]; then
    echo $(get_art) 

elif [ "$1" = "--artist" ]; then
    echo $(get_artist)

elif [ "$1" = "--title" ]; then
    echo $(get_title)

elif [ "$1" = "--status" ]; then
    echo $(get_status)

elif [ "$1" = "--play" ]; then
    playerctl play --no-messages

elif [ "$1" = "--pause" ]; then
    playerctl pause --no-messages

elif [ "$1" = "--toggle" ]; then
    toggle

elif [ "$1" = "--previous" ]; then
    playerctl previous --no-messages

elif [ "$1" = "--next" ]; then
    playerctl next --no-messages

elif [ "$1" = "--position" ]; then
    echo $(get_position)
fi	







