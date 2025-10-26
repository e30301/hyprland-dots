#!/bin/bash
mapfile -t wallpapers < <(find "$HOME/.config/hypr/assets/wallpapers" -type f)
wall="${wallpapers[RANDOM % ${#wallpapers[@]}]}"
swww img "$wall" --transition-fps 60 --transition-type center
