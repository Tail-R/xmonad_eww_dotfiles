#/bin/bash

ewwPath="$HOME/.config/eww"
v0="INDEX_RICESET_CURR"
v1="INDEX_RICESET_NEXT"
v2="INDEX_RICESET_PREV"

get_curr() {
    eww -c $ewwPath get $v0
}

get_next() {
    length=$(eww -c $ewwPath get JSON_RICESET | jq ". | length")
    current=$(eww -c $ewwPath get $v0)
    next=$(( $current + 1 ))

    # Null check
    if [ "$length" == "" ]; then
        return
    fi 

    if [ "$next" == "$length" ]; then
        echo 0
    else
        echo $(( $next ))
    fi
}

get_prev() {
    length=$(eww -c $ewwPath get JSON_RICESET | jq ". | length")
    current=$(eww -c $ewwPath get $v0)
    prev=$(( $current - 1 ))
    
    # Null check
    if [ "$length" == "" ]; then
        return
    fi 

    if [ "$prev" == "-1" ]; then
        echo $(( $length - 1 ))
    else
        echo $prev
    fi
}

incr() {
    length=$(eww -c $ewwPath get JSON_RICESET | jq ". | length")
    current=$(eww -c $ewwPath get $v0)
    next=$(( $current + 1 ))

    # Null check
    if [ "$length" == "" ]; then
        return
    fi
    
    if [ "$next" == "$length" ]; then
        eww -c $ewwPath update $v0="0"
    else
        eww -c $ewwPath update $v0=$next
    fi

    next_next=$(get_next)
    echo $next_next
    eww -c $ewwPath update $v1="$next_next"
    eww -c $ewwPath update $v2="$current"
}

decr() {
    length=$(eww -c $ewwPath get JSON_RICESET | jq ". | length")
    current=$(eww -c $ewwPath get $v0)
    prev=$(( $current - 1 ))

    # Null check
    if [ "$length" == "" ]; then
        return
    fi
    
    if [ "$prev" == "-1" ]; then
        eww -c $ewwPath update $v0="$(( $length - 1 ))"
    else
        eww -c $ewwPath update $v0=$prev
    fi
    
    prev_prev=$(get_prev)
    eww -c $ewwPath update $v1="$current"
    eww -c $ewwPath update $v2="$prev_prev"
}

set_index() {
    length=$(eww -c $ewwPath get JSON_RICESET | jq ". | length")
    
    if [ $(( $1 )) -lt $(( $length )) ]; then
        eww -c $ewwPath update $v0=$1
        
        next=get_next
        prev=get_prev
        
        eww -c $ewwPath update $v1="$next"
        eww -c $ewwPath update $v2="$prev" 
    fi
}

# Main
if [ "$1" == "--get_curr" ]; then
    get_curr
elif [ "$1" == "--get_next" ]; then
    get_next
elif [ "$1" == "--get_prev" ]; then
    get_prev
elif [ "$1" == "--incr" ]; then
    incr
elif [ "$1" == "--decr" ]; then
    decr
elif [ "$1" == "--set_index" ]; then
    set_index $2
fi


