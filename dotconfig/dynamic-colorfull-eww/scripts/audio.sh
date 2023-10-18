#!/bin/bash

######################################################################
## You need to install pamixer
######################################################################

# Main
if [ "$1" == "--get_volume" ]; then
    echo $(amixer -D pulse sget Master \
        | grep "Left:" \
        | awk -F'[][]' '{print $2}' \
        | tr -d "%")
elif [ "$1" == "--get_micvol" ]; then
    echo $(amixer -D pulse sget Capture \
        | grep "Left:" \
        | awk -F'[][]' '{print $2}' \
        | tr -d "%")
fi



