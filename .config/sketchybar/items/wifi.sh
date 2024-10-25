#!/bin/bash

sketchybar --add item wifi right                         \
           --set wifi    script="$PLUGIN_DIR/wifi.sh"    \
                         icon=􀙇                          \
                         update_freq=5
