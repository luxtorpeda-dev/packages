#!/bin/bash

if [ -f "last_error.txt" ]; then
    rm last_error.txt
fi

# Find game's .sh file, ignore run-renpy.sh in results, limit to one result, put in shfile variable
shfile=$(find . -type f \( -iname "*.sh" ! -iname "run-renpy.sh" \) | head -n 1)

# Check if sh file exists and launch game if it does, otherwise give error.
if [ -n "$shfile" ]; then
    echo "Launching game's .sh file from $shfile"
    ./"$shfile"
else
    error_message="Couldn't find game's .sh file."
    echo "$error_message" > last_error.txt
    exit 10
fi
