#!/bin/bash

# Main
if [ "$1" == "--add" ]; then
    sleep 0.2
    # xwd -id $2 | convert xwd:- ./thumbnails/$2.jpg
    maim -i $2 ./thumbnails/$2.jpg
elif [ "$1" == "--del" ]; then
    rm ./thumbnails/$2.jpg
fi
