#!/bin/bash

ewwPath="$HOME/.config/eww"

re_link() {

    if [ -L $ewwPath/scss/color.scss ]; then
        ln -fs $ewwPath/scss/colors/$name.scss $ewwPath/scss/color.scss
    else
        ln -s $ewwPath/scss/colors/$name.scss $ewwPath/scss/color.scss
    fi
}

# Main
name=$(echo $1 | sed -e 's/^--//g')

if [ -f $ewwPath/scss/colors/$name.scss ]; then
    re_link $name
fi
