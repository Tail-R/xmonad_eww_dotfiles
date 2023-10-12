#!/bin/bash

######################################################################
## You need to install pamixer
######################################################################

# Main
if [ "$1" == "--get_vol_sound" ]; then
    echo "$(pamixer --get-volume-human)"   
fi




