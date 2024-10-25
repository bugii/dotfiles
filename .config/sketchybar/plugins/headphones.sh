#!/bin/sh

HEADPHONES_ICON="󰋋"
DISCONNECTED_ICON="󰟎"

# Get the current output device
# Info: this requires "switchaudio-osx" to be installed (can be done via homebrew)
CURRENT_OUTPUT=$(SwitchAudioSource -c)

# Check if the current output device is headphones
if [[ "$CURRENT_OUTPUT" == *"Headphones"* ]]; then
    ICON="$HEADPHONES_ICON"
else
    ICON="$DISCONNECTED_ICON"
fi

sketchybar --set $NAME icon="$ICON"
