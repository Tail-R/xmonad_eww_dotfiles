#!/bin/bash

######################################################################
## You need to install maim
######################################################################

path="$HOME/Pictures/screenshots"

mkdir -p $HOME/Pictures
mkdir -p $path

name=$(date "+%Y%m%d_%H%M%S.png")

case "$1" in
    "-s" ) maim -m 10 -s $path/$name; feh $path/$name ;;
    "-f" ) maim -m 10 $path/$name ;;
esac


