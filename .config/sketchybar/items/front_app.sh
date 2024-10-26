#!/bin/bash

sketchybar --add item front_app left \
           --set front_app       icon.color=$SKY \
                                 label.color=$SKY \
                                 icon.font="sketchybar-app-font:Regular:14.0" \
                                 script="$PLUGIN_DIR/front_app.sh"            \
           --subscribe front_app front_app_switched
