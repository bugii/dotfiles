#!/bin/sh

layout=$(defaults read ~/Library/Preferences/com.apple.HIToolbox.plist AppleSelectedInputSources | grep 'KeyboardLayout Name' | sed -E 's/.* = "(.*)";/\1/')

if [ -z "$layout" ]; then
    layout="SE"
fi

sketchybar --set "$NAME" label="$layout"
