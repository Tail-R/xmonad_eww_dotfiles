#!/bin/bash

######################################################################
## You need to install acpi
######################################################################
get_battery_level() {
    echo $(acpi -b | sed -e "s/[A-Za-z:,-.%]\+//g" | awk 'NR == 1 {print $2}')
}

get_adapter_status() {
    echo "$(acpi -b | awk 'NR == 1 {print $3}' | sed -e 's/,//g')"
}

get_battery_icons() { 
    battery_level=$(get_battery_level)
    battery_level_trunc=$(($battery_level / 10 * 10))

    if [ "$(get_adapter_status)" == "Charging" ]; then    
        # Charging
        case "$battery_level_trunc" in
            "100" ) echo "󰣐 󰣐 󰣐 󰣐 󰣐 󰣐 󰣐 󰣐 󰣐 󰣐"
                return ;;
            "90" ) echo "󰣐 󰣐 󰣐 󰣐 󰣐 󰣐 󰣐 󰣐 󰣐 󰗶"
                return ;;
            "80" ) echo "󰣐 󰣐 󰣐 󰣐 󰣐 󰣐 󰣐 󰣐 󰗶 󱢠" 
                return ;; 
            "70" ) echo "󰣐 󰣐 󰣐 󰣐 󰣐 󰣐 󰣐 󰗶 󱢠 󱢠" 
                return ;;
            "60" ) echo "󰣐 󰣐 󰣐 󰣐 󰣐 󰣐 󰗶 󱢠 󱢠 󱢠"
                return ;;
            "50" ) echo "󰣐 󰣐 󰣐 󰣐 󰣐 󰗶 󱢠 󱢠 󱢠 󱢠"
                return ;;
            "40" ) echo "󰣐 󰣐 󰣐 󰣐 󰗶 󱢠 󱢠 󱢠 󱢠 󱢠"
                return ;; 
            "30" ) echo "󰣐 󰣐 󰣐 󰗶 󱢠 󱢠 󱢠 󱢠 󱢠 󱢠"
                return ;;
            "20" ) echo "󰣐 󰣐 󰗶 󱢠 󱢠 󱢠 󱢠 󱢠 󱢠 󱢠"
                return ;;
            "10" ) echo "󰣐 󰗶 󱢠 󱢠 󱢠 󱢠 󱢠 󱢠 󱢠 󱢠"
                return ;;
            "0"  ) echo "󰗶 󱢠 󱢠 󱢠 󱢠 󱢠 󱢠 󱢠 󱢠 󱢠"
                return ;; 
        esac                                
    else
        # Discharging
        case "$battery_level_trunc" in
            "100" ) echo "󰣐 󰣐 󰣐 󰣐 󰣐 󰣐 󰣐 󰣐 󰣐 󰣐"
                return ;;
            "90" ) echo "󰣐 󰣐 󰣐 󰣐 󰣐 󰣐 󰣐 󰣐 󰣐 󰛞"
                return ;;
            "80" ) echo "󰣐 󰣐 󰣐 󰣐 󰣐 󰣐 󰣐 󰣐 󰛞 󱢠" 
                return ;; 
            "70" ) echo "󰣐 󰣐 󰣐 󰣐 󰣐 󰣐 󰣐 󰛞 󱢠 󱢠" 
                return ;;
            "60" ) echo "󰣐 󰣐 󰣐 󰣐 󰣐 󰣐 󰛞 󱢠 󱢠 󱢠"
                return ;;
            "50" ) echo "󰣐 󰣐 󰣐 󰣐 󰣐 󰛞 󱢠 󱢠 󱢠 󱢠"
                return ;;
            "40" ) echo "󰣐 󰣐 󰣐 󰣐 󰛞 󱢠 󱢠 󱢠 󱢠 󱢠"
                return ;; 
            "30" ) echo "󰣐 󰣐 󰣐 󰛞 󱢠 󱢠 󱢠 󱢠 󱢠 󱢠"
                return ;;
            "20" ) echo "󰣐 󰣐 󰛞 󱢠 󱢠 󱢠 󱢠 󱢠 󱢠 󱢠"
                return ;;
            "10" ) echo "󰣐 󰛞 󱢠 󱢠 󱢠 󱢠 󱢠 󱢠 󱢠 󱢠"
                return ;;
            "0"  ) echo "󰛞 󱢠 󱢠 󱢠 󱢠 󱢠 󱢠 󱢠 󱢠 󱢠"
                return ;; 
        esac
    fi 
}

# Main
if [ "$1" == "--level" ]; then
    get_battery_level

elif [ "$1" == "--icons" ]; then
    get_battery_icons
fi





