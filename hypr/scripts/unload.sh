#!/bin/bash

# Get the class of the currently focused window
win_class=$(hyprctl activewindow | grep Class | awk '{print $2}')

# Map window class to executable name
case "$win_class" in
    VSCodium)
        target="codium"
        ;;
    Firefox)
        target="firefox"
        ;;
    Gedit)
        target="gedit"
        ;;
    *)
        target="$win_class"
        ;;
esac

# Get all PIDs of the executable
pids=$(pidof "$target")

if [ -z "$pids" ]; then
    notify-send "No process found for $win_class ($target)"
    exit 1
fi

# Check first PID state
first_pid=$(echo $pids | awk '{print $1}')
state=$(ps -o state= -p "$first_pid" | tr -d ' ')

# Freeze/unfreeze all
if [[ "$state" == "T" ]]; then
    kill -CONT $pids
    notify-send "$win_class unfrozen"
else
    kill -STOP $pids
    notify-send "$win_class frozen"
fi
