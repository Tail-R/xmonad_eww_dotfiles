#!/bin/bash

imgDirPath="$HOME/.config/eww/scripts/gen_win_thumbnailis/thumbnails"

add_win_thumb() {
    maim -i $1 ./thumbnails/$1.jpg 
}

del_win_thumb() {
    rm ./thumbnails/$1.jpg 
}


# Main
if [ "$1" == "0" ]; then
    add_win_thumb $2
elif [ "$1" == "1" ]; then
    del_win_thumb $2
fi
