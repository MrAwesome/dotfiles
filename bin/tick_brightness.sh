#!/bin/bash

set -euo pipefail

percent_increment=3

output=$(brightnessctl -m)
cur=$(echo "$output" | cut -d, -f 3)
percent=$(echo "$output" | cut -d, -f 4 | sed 's/%$//')
max=$(echo "$output" | cut -d, -f 5)

command=${1:-get}

case "$command" in
    get)
        echo "$cur/$max = $percent%";;
    min)
        brightnessctl s 1;;
    max)
        brightnessctl s 100%;;
    up)
        brightnessctl s +"$percent_increment"%;;
    down)
        if [ "$percent" -le "$((percent_increment*2))" ]; then
            # Go down by percent_increment, then 
            if [ "$percent" -gt "$percent_increment" ]; then
                brightnessctl s "$percent_increment"%
            elif [ "$percent" -gt 1 ]; then
                brightnessctl s 1%
            else
                brightnessctl s 1
            fi
        else
            brightnessctl s "$percent_increment"%-
        fi
        ;;
esac

#brightnessctl s +5% 
#brightnessctl s 5%- 
#brightnessctl s 100%
#brightnessctl s 1%  
