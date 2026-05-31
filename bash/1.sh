#!/bin/bash
duration=${1:-60}
interval=30     
end_time=$((SECONDS + duration))

while [ $SECONDS -lt $end_time ]; do
    current_datetime=$(date +"%d.%m %H:%M")
    year=$(date +%Y)
    source="kubsu.tyvik.ru"
    load=$(cat /proc/loadavg)
    
    echo "[$current_datetime]($source).$year = $load"
    
    if [ $SECONDS -lt $end_time ]; then
        sleep $interval
    fi
done