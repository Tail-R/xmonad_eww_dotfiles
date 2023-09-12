#!/bin/bash

if [ ! -d $HOME/Pictures ]; then
       mkdir $HOME/Pictures
fi

if [ ! -d $HOME/Pictures/wallpapers ]; then
    mkdir $HOME/Pictures/wallpapers
fi

# Get list of the path
wallPathArray=$(ls -1 $HOME/Pictures/wallpapers/*)

# Random value that 1 to MAX
index=$(( (`echo $RANDOM`) % (`echo $wallPathArray | tr -dc ' ' | wc -c` + 1) + 1 ))

# Chose a wallpaper 
path=$(echo $wallPathArray | cut -d " " -f $index)

# Set wallpaper
feh --bg-fill $path




