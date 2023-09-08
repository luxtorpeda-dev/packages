#!/bin/bash

# Define the app ID
app_id="32310"

# Check if a command argument was provided
if [ $# -eq 1 ]; then
    command_args="$1"

    # Check if the command argument is "official"
    if [ "$command_args" == "official" ]; then
        compat_tool="\"\""
    else
        compat_tool="$command_args"
    fi
else
    echo "Usage: $0 <compat_tool>"
    echo "Example: luxtorpeda, official, steamlinuxruntime, proton_8, proton_experimental, GE-Proton8-14"
    exit 1
fi

# Construct the Steam command
steam_command="steam -applaunch $app_id \"steam://nav/console/ +app_change_compat_tool $app_id $compat_tool \\\"\\\" 250\""

# Execute the Steam command
echo "Launching $app_id with $compat_tool"
eval "$steam_command"
