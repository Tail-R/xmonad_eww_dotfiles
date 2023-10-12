#! /bin/bash

ewwPath="$HOME/.config/eww/"

get_device_name() {
    if [ "$(get_con_status)" == "connected" ]; then
        knownDeviceNumber=$(bluetoothctl devices | awk '{print $2}')

        for deviceNumber in $knownDeviceNumber; do
            if [ "$(bluetoothctl info $deviceNumber | grep Connected: | awk '{print $2}')" == "yes" ]; then
                echo $(bluetoothctl info $deviceNumber | grep Name: | awk '{print $2}') 
                return
            fi
        done
    fi
        
    echo "--"
}

get_con_status() {
    knownDeviceNumber=$(bluetoothctl devices | awk '{print $2}')

    for deviceNumber in $knownDeviceNumber; do
        conStatus=$(bluetoothctl info $deviceNumber | grep Connected: | awk '{print $2}')
        if [ "$conStatus" == "yes" ]; then
            echo "connected"
            return
        fi
    done

    echo "disconnected"
}

toggle() {
    if [ "$(get_con_status)" == "connected" ]; then
        bluetoothctl disconnect
    else
        knownDeviceNumber=$(bluetoothctl devices | awk '{print $2}')
        
        for deviceNumber in $knownDeviceNumber; do
            bluetoothctl connect $deviceNumber 
        done    
    fi  
}

update_eww_json() {
    deviceNameList=$(bluetoothctl devices | awk '{print $2}')

    # Create json array
    deviceNameListJson=[\"$(echo $deviceNameList | sed -e 's/ /", "/g')\"]
    eww -c $ewwPath update BT_NAME_ARRAY="$deviceNameListJson"
}

# Main
if [ "$1" == "--con_status" ]; then
    get_con_status
elif [ "$1" == "--devname" ]; then
    get_device_name
elif [ "$1" == "--toggle" ]; then
    toggle
elif [ "$1" == "--update_eww_json" ]; then
    update_eww_json
fi










