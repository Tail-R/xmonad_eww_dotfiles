#!/bin/bash

ewwPath="$HOME/.config/eww/popup"

if [ ! -d $ewwPath/json ]; then
    mkdir $ewwPath/json
fi

if [ ! -f $ewwPath/json/notify_array.json ]; then
    touch $ewwPath/json/notify_array.json
fi

# Main
if [ "$1" == "--send" ]; then
    if [ "$3" == "" -o "$4" != "" ]; then
        echo "invalid arguments"
    else
        # Time stamp
        DATE=$(date '+%Y%m%d%H%M%S')
        eww_json_before=$(eww -c $ewwPath get NOTIFY_ARRAY)
        
        # Create json files
        echo $eww_json_before > $ewwPath/json/notify_array.json
        echo "[\"$2\", \"$3\"]" > $ewwPath/json/notify_message$DATE.json
       
        # Run python script 
        echo $($(which python) $ewwPath"/scripts/notify_json_edit.py" --add $DATE)
        
        eww_json_after=$(cat $ewwPath/json/notify_array.json)
 
        eww -c $ewwPath update NOTIFY_ARRAY="$eww_json_after"

        # Delete message file
        rm $ewwPath/json/notify_message$DATE.json 
    fi
elif [ "$1" == "--remove" ]; then
    if [ "$2" == "" -o "$3" != "" ]; then
        echo "Invalid arguments"
    else
        eww_json_before=$(eww -c $ewwPath get NOTIFY_ARRAY)
        
        # Create json file
        echo $eww_json_before > $ewwPath/json/notify_array.json
        
        # Run python script
        echo $($(which python) $ewwPath"/scripts/notify_json_edit.py" --remove $2)

        eww_json_after=$(cat $ewwPath/json/notify_array.json)
        
        # echo $eww_json_after
        
        eww -c $ewwPath update NOTIFY_ARRAY="$eww_json_after"
    fi
fi









