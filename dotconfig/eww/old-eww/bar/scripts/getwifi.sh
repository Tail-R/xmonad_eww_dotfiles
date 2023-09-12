#!/bin/bash

ICON=""
STATUS=$(nmcli g | awk '{print $1}' | grep connected)

if [ "$STATUS" == "connected" ]; then
    echo "1"
else
    echo "0"
fi
