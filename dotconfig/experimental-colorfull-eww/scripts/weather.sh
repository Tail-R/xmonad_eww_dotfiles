#!/bin/bash

######################################################################
#   Put in your api and stuff link here 
#   If you dunno, head to openweathermap.org, and make and account 
#   (completely free I swear, and then get your API Key and  your City ID)
#   I wish I was smart enough to do it like Elena, but this is the top I could do lol
#
#   From Github.com/Axarva/dotfiles-2.0
#
#   And this script require "jq" command
######################################################################

KEY="580b0c4f99b71700c309e7f90cafabc8"
ID="Tokyo"
UNIT="metric"   # Available values : metric, imperial

get_conditions() {
    wheather_json=$(curl -s "https://api.openweathermap.org/data/2.5/weather?q=$ID&units=$UNIT&APPID=$KEY")
    echo $wheather_json | jq '.weather[0].main' | sed -e 's/"//g'
}

get_temperature() {
    wheather_json=$(curl -s "https://api.openweathermap.org/data/2.5/weather?q=$ID&units=$UNIT&APPID=$KEY")
    echo $wheather_json | jq '.main.temp' | awk '{printf "%d\n", $1}'
}

# Main
if [ "$1" == "--conditions" ]; then
    get_conditions
elif [ "$1" == "--temperature" ]; then
    get_temperature
elif [ "$1" == "--locale" ]; then
    echo $ID
fi



