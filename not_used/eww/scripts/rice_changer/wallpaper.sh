#!/bin/bash

######################################################################
## You need to install feh
######################################################################

ewwPath="$HOME/.config/eww"

if [ ! -d $HOME/Pictures ]; then
       mkdir $HOME/Pictures
fi

if [ ! -d $HOME/Pictures/wallpapers ]; then
    mkdir $HOME/Pictures/wallpapers
fi

set_wall() {
    if [ -a $HOME/Pictures/wallpapers/$1 ]; then
        path="$HOME/Pictures/wallpapers/$1"

        # Create link to the original source
        rm -f $ewwPath/images/currentwall/*
        ln -s $path $ewwPath/images/currentwall/currentwall

        # Create Blurred version
        $ewwPath/scripts/convert_images/./convert_images.py -b $ewwPath/images/currentwall/currentwall "/images/currentwall"
        
        # Set wallpaper
        feh --bg-fill $path
    fi
}

set_rand_wall() {
    # Get list of the path
    wallPathArray=$(ls -1 $HOME/Pictures/wallpapers/*)
    
    # Random value that 1 to MAX
    index=$(( (`echo $RANDOM`) % (`echo $wallPathArray | tr -dc ' ' | wc -c` + 1) + 1 ))
    
    # Chose a wallpaper 
    path=$(echo $wallPathArray | cut -d " " -f $index)
    
    # Create link to the original source
    rm -f $ewwPath/images/currentwall/*
    ln -s $path $ewwPath/images/currentwall/currentwall
    
    # Create Blurred version
    $ewwPath/scripts/convert_images/./convert_images.py -b $ewwPath/images/currentwall/currentwall "/images/currentwall"
    
    # Set wallpaper
    feh --bg-fill $path
}

# Main
if [[ "$1" == "--set" && "$2" != "" ]]; then
    set_wall $2
elif [[ "$1" == "--set_rand_wall" ]]; then
    set_rand_wall
fi




