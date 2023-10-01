#!/bin/bash

ewwPath="$HOME/.config/eww"

event_page0() {
    centerBarStatus=$(eww -c $ewwPath get SHOW_CENTER_BAR)
    page0Status=$(eww -c $ewwPath get SHOW_CENTER_BAR_PAGE0)

    case $centerBarStatus in
        "true" )
            echo $page0Status
            if [ "$page0Status" == "true" ]; then
                `eww -c $ewwPath update SHOW_CENTER_BAR=false` 
            elif [ "$page0Status" == "false" ]; then
                `eww -c $ewwPath update SHOW_CENTER_BAR_PAGE_SWITCHER=false SHOW_CENTER_BAR_PAGE0=true SHOW_CENTER_BAR_PAGE1=false SHOW_CENTER_BAR_PAGE2=false`
            fi
        ;;
            
        "false" ) `eww -c $ewwPath update SHOW_CENTER_BAR_PAGE_SWITCHER=false SHOW_CENTER_BAR=true SHOW_CENTER_BAR_PAGE0=true SHOW_CENTER_BAR_PAGE1=false SHOW_CENTER_BAR_PAGE2=false` ;;
    esac
}

event_page1() {
    centerBarStatus=$(eww -c $ewwPath get SHOW_CENTER_BAR)
    page1Status=$(eww -c $ewwPath get SHOW_CENTER_BAR_PAGE1)

    case $centerBarStatus in
        "true" )
            echo $page1Status
            if [ "$page1Status" == "true" ]; then
                `eww -c $ewwPath update SHOW_CENTER_BAR=false` 
            elif [ "$page1Status" == "false" ]; then
                `eww -c $ewwPath update SHOW_CENTER_BAR_PAGE_SWITCHER=false SHOW_CENTER_BAR_PAGE0=false SHOW_CENTER_BAR_PAGE1=true SHOW_CENTER_BAR_PAGE2=false`
            fi
        ;;
            
        "false" ) `eww -c $ewwPath update SHOW_CENTER_BAR_PAGE_SWITCHER=false SHOW_CENTER_BAR=true SHOW_CENTER_BAR_PAGE0=false SHOW_CENTER_BAR_PAGE1=true SHOW_CENTER_BAR_PAGE2=false` ;;
    esac
}

event_page2() {
    centerBarStatus=$(eww -c $ewwPath get SHOW_CENTER_BAR)
    page2Status=$(eww -c $ewwPath get SHOW_CENTER_BAR_PAGE2)

    case $centerBarStatus in
        "true" )
            echo $page2Status
            if [ "$page2Status" == "true" ]; then
                `eww -c $ewwPath update SHOW_CENTER_BAR=false` 
            elif [ "$page2Status" == "false" ]; then
                `eww -c $ewwPath update SHOW_CENTER_BAR_PAGE_SWITCHER=false SHOW_CENTER_BAR_PAGE0=false SHOW_CENTER_BAR_PAGE1=false SHOW_CENTER_BAR_PAGE2=true`
            fi
        ;;
            
        "false" ) `eww -c $ewwPath update SHOW_CENTER_BAR_PAGE_SWITCHER=false SHOW_CENTER_BAR=true SHOW_CENTER_BAR_PAGE0=false SHOW_CENTER_BAR_PAGE1=false SHOW_CENTER_BAR_PAGE2=true` ;;
    esac
}

# Main
case $1 in 
    "--event_page0" ) event_page0 ;;
    "--event_page1" ) event_page1 ;;
    "--event_page2" ) event_page2 ;;
esac

