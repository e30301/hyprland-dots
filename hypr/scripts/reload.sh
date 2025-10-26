#!/bin/bash

# Get the directory of this script
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"

# Run wallpaper.sh from the same directory
"$SCRIPT_DIR/wallpaper.sh"

# Give it a moment to set the wallpaper
sleep 4

# Get current wallpaper from swww
WALLPAPER=$(swww query | grep "currently displaying" | awk -F'image: ' '{print $2}' | xargs)

swww query | grep "currently displaying" | awk -F'image: ' '{print $2}' | xargs > ~/.config/hypr/scripts/wallpaper.txt

if [ -z "$WALLPAPER" ]; then
    echo "No wallpaper detected, exiting."
    exit 1
fi

# Generate pywal color scheme
wal -i "$WALLPAPER"
sleep 1
pywalfox update
# Restart waybar to apply new colors
#pkill -9 waybar
#waybar &

