#!/bin/bash

get_resolution_width() {
    echo $(xrandr --current | grep '*' | uniq | awk '{print $1}' | sed -e 's/x[0-9]*//g')
}

get_resolution_height() {
    echo $(xrandr --current | grep '*' | uniq | awk '{print $1}' | sed -e 's/[0-9]*x//g')
}

# Main
if [ "$1" == "--width" ]; then
    get_resolution_width
elif [ "$1" == "--height" ]; then
    get_resolution_height
fi




