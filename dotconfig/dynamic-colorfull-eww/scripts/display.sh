#!/bin/bash

######################################################################
## You need to install xrandr brightnessctl
######################################################################
get_resolution_width() {
    echo $(xrandr --current | grep '*' | uniq | awk '{print $1}' | sed -e 's/x[0-9]*//g')
}

get_resolution_height() {
    echo $(xrandr --current | grep '*' | uniq | awk '{print $1}' | sed -e 's/[0-9]*x//g')
}

# Get a primary display name like a eDP-1, LVDS-1, ...
get_dp_name() {
    echo $(xrandr | grep "primary" | awk '{print $1}')
}

get_bright_level() {
    max_level=$(brightnessctl m)
    current_level=$(brightnessctl g)

    echo $((current_level * 100 / max_level))
}

set_max_brightness() {
    if [ $(echo "1 > $1 > 0" | bc) == 1 ]; then
        dpName=$(get_dp_name)
        $(xrandr --output $dpName --brightness $1)
    fi
}

toggle_nightmode() {
    dpName=$(get_dp_name)

    if [ "$(xrandr --verbose | grep "Brightness:" | awk 'NR == 1 {print $2}')" == "1.0" ]; then
        xrandr --output $dpName --brightness 0.7
    else
        xrandr --output $dpName --brightness 1
    fi
}

# If the nightmode is enabled return true
get_nightmode_status() {
    if [ "$(xrandr --verbose | grep "Brightness:" | awk 'NR == 1 {print $2}')" == "1.0" ]; then
        echo false
    else
        echo true
    fi
}

# Main
if [ "$1" == "--get_dp_width" ]; then
    get_resolution_width
elif [ "$1" == "--get_dp_height" ]; then
    get_resolution_height
elif [ "$1" == "--get_dp_name" ]; then
    get_dp_name
elif [ "$1" == "--get_brightness" ]; then
    get_bright_level
elif [ "$1" == "--set_max_brightness" ]; then
    set_max_brightness $2
elif [ "$1" == "--toggle_nightmode" ]; then
    toggle_nightmode
elif [ "$1" == "--get_nightmode_status" ]; then
    get_nightmode_status
fi




