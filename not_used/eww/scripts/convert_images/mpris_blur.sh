#!/bin/bash

######################################################################
## You need to install playerctl
######################################################################

workDir="$HOME/.config/eww/scripts/convert_images"

cd $workDir

mkdir -p ./images
mkdir -p ./images/mpris

# Main
playerctl --follow metadata | while read -r metadata; do
    imgPath=$(echo $metadata | grep mpris:artUrl | sed -e 's/.*file:\/\///g')
    
    if [ -a ./imgaes/mpris/* ]; then
        rm ./images/mpris/*
    fi

    if [ "$(playerctl -l | grep 'firefox')" != "" ]; then
        if [ "$imgPath" != "" ]; then
            ./convert_images.py -b $imgPath "/images/mpris"
        fi
    else
        echo $imgPath
    fi
done



