#! /bin/bash

get_device_name() {
    if [ "$(get_con_status)" == "connected" ]; then
        echo $(bluetoothctl devices | awk 'NR == 1 {print $3}')
    else
        echo "No BT device founded"
    fi
}

get_con_status() {
    deviceNumber=$(bluetoothctl devices | awk 'NR == 1 {print $2}')
    conStatus=$(bluetoothctl info $deviceNumber | grep Connected: | awk '{print $2}') 

    if [ "$conStatus" == "yes" ]; then
        echo "connected" 
    else
        echo "disconnected"
    fi 
}

toggle() {
    if [ "$(get_con_status)" == "connected" ]; then
        bluetoothctl disconnect
    else
        deviceNumber=$(bluetoothctl devices | awk 'NR == 1 {print $2}')
        bluetoothctl connect $deviceNumber 
    fi  
}

# Main
if [ "$1" == "--con_status" ]; then
    get_con_status
elif [ "$1" == "--device" ]; then
    get_device_name
elif [ "$1" == "--toggle" ]; then
    toggle
fi










