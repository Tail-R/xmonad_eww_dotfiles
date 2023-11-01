#/bin/bash

# Main
if [ "$1" == "--poweroff" ]; then
    systemctl poweroff
elif [ "$1" == "--suspend" ]; then
    systemctl suspend
elif [ "$1" == "--logout" ]; then
    kill -9 -1 # Note: search more smart way
elif [ "$1" == "--reboot" ]; then
    systemctl reboot
fi

