#!/bin/bash

check_occupied() {
    wmctrl -l | awk '{print $2}' | uniq | while read -r op; do
        if [ "$op" == "$1" ]; then
            echo "true"
            return
        fi
    done
}

# Main
xprop -spy -root _NET_CURRENT_DESKTOP | while read -r; do
    wsNumber=$(wmctrl -d | awk '{print $1}' | tail -c 2)

    wmctrl -d | awk '{print $1 " " $2 " " $9}' | while read -r number status name; do
        statusClass="ws_inactive"
        icon="󰧞"

        if [ "$(check_occupied $number)" == "true" ]; then
            statusClass="ws_occupied"
            # icon="󰊠"
            # icon=""
            icon="󰮿"
        fi

        if [ "$status" == "*" ]; then # "*" mean active
            statusClass="ws_active"
            # icon="󰮯"
            # icon=""
            icon=""
        fi

        buffered+=$' '
        buffered+="(label :class '$statusClass' :text '$icon')"

        if [ "$number" == "$wsNumber" ]; then
            echo "(box :space-evenly false :spacing 20 $buffered)"
        fi
    done
done





