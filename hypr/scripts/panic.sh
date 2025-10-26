#!/bin/bash

#panic button

#workspace 11

hyprctl dispatch workspace 11
#stop sound
playerctl pause
#volume down
wpctl set-volume @DEFAULT_AUDIO_SINK@ 0%

# kitty
hyprctl dispatch exec "[workspace 11] codium"
