#!/bin/bash

######################################################################
## You need to install hostnamectl, wmctrl
######################################################################

fet_all() {
    fet_hostname
    fet_distro
    fet_model
    fet_wmname
}

fet_hostname() {
    echo $(whoami)@$(hostname) 
}

fet_distro() {
    cat /etc/os-release | grep -E "^NAME" | sed -e 's/^.*=//g' -e 's/"//g'
}

fet_model() {
    hostnamectl | grep "Hardware Model" | sed -e 's/ *Hardware Model: //g'
}

fet_wmname() {
    wmctrl -m | grep "Name:" | awk '{print $2}'
}

# Main
if [ "$1" == "" ]; then
    fet_all
elif [ "$1" == "--hostname" ]; then
    fet_hostname
elif [ "$1" == "--distro" ]; then
    fet_distro
elif [ "$1" == "--model" ]; then
    fet_model
elif [ "$1" == "--wmname" ]; then
    fet_wmname
fi
