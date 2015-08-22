EXECUTABLE_FILE(batt_mon, ~/bin/batt_mon)
#!/bin/bash
set -eu

last=

while true; do
    capacity=$(cat /sys/class/power_supply/BAT0/capacity)
    status=$(cat /sys/class/power_supply/BAT0/status)
    
    if [ x$status:$capacity != x$last ]; then
        case $status in
            Discharging)
                if [ $capacity -le 5 ]; then
                    notify-send -u critical "$status: $capacity%"
                elif [ $capacity -le 10 ]; then
                    notify-send -u normal "$status: $capacity%"
                elif [ $capacity -le 15 ]; then
                    notify-send -u low "$status: $capacity%"
                elif [ $(($capacity % 10)) -eq 0 ]; then
                    notify-send -t 5000 -u low "$status: $capacity%"
                fi
                ;;
        esac
    fi
    
    last=$status:$capacity
    sleep 10
done
