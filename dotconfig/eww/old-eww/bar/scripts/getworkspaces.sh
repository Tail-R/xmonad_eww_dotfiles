#!/bin/bash

check_occupied () {
    wmctrl -l \
	| awk '{print $2}' | while read -r occupied; do

	if [ "$occupied" == "$1" ]; then
	    echo "occupied"
	    return
	fi
    done
}

get_workspaces_yuck() {
    buffered=""

    wmctrl -d \
	| awk '{print $1 " " $2}' \
	| while read -r number active; do

	occupied=$(check_occupied $number)

	if [ "$active" == "-" ]; then
	    active_class="inactive"
	    icon="󰋔"
	fi

	if [ "$occupied" == "occupied" ]; then
	    active_class="occupied"
	    icon="󱢠"
	fi
	    
	if [ "$active" == "*" ]; then
	    active_class="active"
	    icon="󰣐"
	fi

	#echo "---------------------------"
	#echo "$number $active_class $icon"

	buffered+=$'\n'
	buffered+="(button :class '$active_class' :onclick 'wmctrl -s $number' '$icon')"
	
	if [ "$number" == "4" ]; then
	    echo "$buffered"
	    #echo "end"
	fi
    done
}

BOXCLASS=":class 'workspaces' :orientation 'h' :space-evenly true :spacing 10"
STATUS=`get_workspaces_yuck`

#/home/tailr/eww/target/release/./eww -c ~/.config/eww/bar/ update \
    YUCK="(box $BOXCLASS $STATUS)"

echo "(box $BOXCLASS $STATUS)"
#echo "($STATUS)"


