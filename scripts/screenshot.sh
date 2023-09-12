#!/bin/bash

if [ ! -d $HOME/Pictures ]; then
       mkdir $HOME/Pictures
fi

if [ ! -d $HOME/Pictures/screenshots ]; then
	mkdir $HOME/Pictures/screenshots
fi

path="$HOME/Pictures/screenshots"
name=$(date '+screenShot%Y%m%d_%H%M%S.jpg')

# Take screenshot
case "$1" in
    "--select" ) maim -m 10 -s $path/$name ; feh $path/$name ;;
    "--full"   ) maim -m 10 $path/$name ;;
esac


