#!/bin/bash

get_resolution() {
    geometry=$(xrandr \
        | grep current \
        | sed -e 's/,//g' -e 's/Screen [0-9]*: //g' -e 's/minimum [0-9]* x [0-9]* //g' -e 's/maximum [0-9]* x [0-9]*//g' -e 's/current //')
     
    if [ "$1" == "w" ]; then
        echo $geometry | awk '{print $1}'
    elif [ "$1" == "h" ]; then  
        echo $geometry | awk '{print $3}'
    fi
}


# Main
if [ "$1" == "--width" ]; then
    get_resolution w
elif [ "$1" == "--height" ]; then
    get_resolution h
fi





