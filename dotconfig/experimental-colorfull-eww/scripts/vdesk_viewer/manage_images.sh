#!/bin/bash

fmt="jpg"

# Main
if [ "$1" == "--add" ]; then
    for i in `seq 1 5`; do   
        if [ $(xprop -id $2 | grep "window state:" | awk 'NR == 1 {print $3}') == "Normal" ]; then
            maim -i $2 -u -m 3 ./thumbnails/$2.$fmt
        fi

        sleep 0.1
    done
elif [ "$1" == "--del" ]; then
    if [ -e ./thumbnails/$2.$fmt ]; then
        rm ./thumbnails/$2.$fmt
    fi
fi
