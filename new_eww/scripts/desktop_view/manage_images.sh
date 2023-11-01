#!/bin/bash

fmt="jpg"

# Main
if [ "$1" == "--add" ]; then
    # for i in `seq 1 3`; do   
    #     if [ $(xprop -id $2 | grep "window state:" | awk 'NR == 1 {print $3}') == "Normal" ]; then
    #         maim -i $2 -u -m 3 ./images/$2.$fmt
    #     fi

    #    sleep 0.1
    # done
    sleep 0.1
    maim -i $2 -u ./images/$2.$fmt
    # xwd -id $2 | convert xwd:- ./images/$2.$fmt
elif [ "$1" == "--del" ]; then
    if [ -e ./images/$2.$fmt ]; then
        rm ./images/$2.$fmt
    fi
fi
