#!/bin/bash

get_bright_level() {
    max_level=$(brightnessctl m)
    current_level=$(brightnessctl g)

    echo $((current_level * 100 / max_level))
}

# Main
if [ "$1" == "--level" ]; then
    get_bright_level
fi




