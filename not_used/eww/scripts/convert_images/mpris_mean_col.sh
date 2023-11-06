#!/bin/bash

######################################################################
## You need to install playerctl
######################################################################

workDir="$HOME/.config/eww/scripts/convert_images"

cd $workDir

# Main
playerctl --follow metadata | while read -r metadata; do
    imgPath=$(echo $metadata | grep mpris:artUrl | sed -e 's/.*file:\/\///g')
    
    # if [ "$(playerctl -l | grep 'firefox')" != "" ]; then
        ./convert_images.py -c $imgPath
    # fi
done



