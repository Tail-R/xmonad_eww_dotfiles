#!/bin/bash

ewwPath="$HOME/.config/eww/popup"

get_con_status() {
    if [ "$(nmcli g | awk '{print $1}' | grep connected)" == "connected" ]; then
        echo "connected" 
    else
        echo "disconnected"
    fi
}

get_ssid() {
    ssid=$(nmcli device show | grep GENERAL.CONNECTION | grep -v -E "\slo$")
    echo $(echo $ssid | awk 'NR == 1 {print $2}')
}

toggle() {
    conName=$(nmcli con show | grep -v -E "^lo\s" | awk 'NR == 2 {print $1}')
    
    if [ "$(get_con_status)" == "connected" ]; then
        nmcli con down $conName  
    else
        nmcli con up $conName
    fi
}

update_eww_json() {
    ssidList=$(sudo iw wlan0 scan | grep "SSID:" | awk '{print $2}' | sort | uniq | grep "^[A-Za-z].*$") 
    
    # Create json array
    ssidJson=[\"$(echo $ssidList | sed -e 's/ /", "/g')\"]

    eww -c $ewwPath update SSID_ARRAY="$ssidJson"
}

# Main
if [ "$1" == "--con_status" ]; then
    get_con_status
elif [ "$1" == "--ssid" ]; then
    get_ssid
elif [ "$1" == "--toggle" ]; then
    toggle
elif [ "$1" == "--update_eww_json" ]; then
    update_eww_json
fi












