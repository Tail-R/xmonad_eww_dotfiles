#!/bin/bash

######################################################################
## You need to install wmctrl
######################################################################

killWin() {
    if [ "$1" != "" ]; then
        wmctrl -ic $(echo $1 | sed -e s/\.jpg//g)
    fi
}

# Main
if [ "$1" == "--kill" ]; then
    killWin $2
fi

