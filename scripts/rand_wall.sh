#!/bin/bash

######################################################################
## You need to install feh
######################################################################

mkdir -p $HOME/Pictures
mkdir -p $HOME/Pictures/wallpapers

walls_array=$(ls -1 $HOME/Pictures/wallpapers/*)

if [ "$walls_array" != "" ]; then
    index=$(( (`echo $RANDOM`) % (`echo $walls_array | tr -dc ' ' | wc -c` + 1) + 1 ))   
    path=$(echo $walls_array | cut -d " " -f $index)
    
    feh --bg-fill $path
fi

