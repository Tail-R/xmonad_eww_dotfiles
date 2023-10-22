#!/bin/bash

######################################################################
## You need to install playerctl
######################################################################

workDir="$HOME/.config/eww/scripts/convert_images"

cd $workDir

if [ ! -d ./images ]; then
    mkdir ./images
fi

# Main
playerctl --follow metadata | while read -r metadata; do
imgPath=$(echo $metadata | grep mpris:artUrl | sed -e 's/.*file:\/\///g')
    if [ -a ./imgaes/* ]; then
        rm ./images/*
    fi

    if [ "$(playerctl -l | grep 'firefox')" != "" ]; then
        if [ "$imgPath" != "" ]; then
            ./convert_images.py -b $imgPath
        fi
    else
        echo $imgPath
    fi
done



