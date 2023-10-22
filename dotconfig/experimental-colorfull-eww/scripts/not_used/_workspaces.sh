#!/bin/bash

######################################################################
# You need to install wmctrl, xdotool and nerd-font
######################################################################

check_occupied() {
    wmctrl -l | awk '{print $2}' | while read -r occupied; do
        if [ "$occupied" == "$1" ]; then
            echo "occupied"
            return
        fi
    done
}

get_workspaces_yuck() {
    workspacesNumber=$(wmctrl -d | awk '{print $1}' | tail -c 2)
 
    wmctrl -d | awk '{print $1 " " $2 " " $9}' \
        | while read -r number status name;
    do
        statusClass="workspace_inactive"
        icon="󰧞"

        if [ "$(check_occupied $number)" == "occupied" ]; then
            statusClass="workspace_occupied"
            icon=""
            # icon="󰊠"
        fi
         
        if [ "$status" == "*" ]; then   # "*" mean active
            statusClass="workspace_active"
            icon=""
            # icon="󰮯"
        fi

        buffered+=$'\n'
        buffered+="(label :class '$statusClass' :text '$icon')"
        
        if [ "$number" == "$workspacesNumber" ]; then
            echo "(box :space-evenly false :spacing 20 $buffered)"
        fi
    done
}

get_activewindow_name() {
    windowName=$(xdotool getwindowfocus getwindowname)
    
    if [ "$windowName" == "" ]; then
        echo "inactive"
    else
        echo "$windowName"
    fi
}

# Main
if [ "$1" == "--yuck" ]; then
    get_workspaces_yuck
elif [ "$1" == "--active_winname" ]; then
    get_activewindow_name
fi



