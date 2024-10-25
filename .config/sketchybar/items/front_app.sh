#!/bin/bash

sketchybar --add item front_app left \
           --set front_app       icon.color=$WHITE \
                                 icon.font="sketchybar-app-font:Regular:14.0" \
                                 icon.padding_left=0 \
                                 script="$PLUGIN_DIR/front_app.sh"            \
           --subscribe front_app front_app_switched
