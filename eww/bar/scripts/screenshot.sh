#!/bin/bash

path="$HOME/Pictures/screenshots"
name=$(date '+screenShot%Y%m%d_%H%M%S.jpg')

# Take screenshot
case "$1" in
    "--select" ) maim -m 10 -s $path/$name ; feh $path/$name ;;
    "--full"   ) maim -m 10 $path/$name ;;
esac


