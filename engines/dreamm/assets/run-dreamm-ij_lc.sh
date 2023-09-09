#!/bin/bash

# Define the target directory
target_directory="install/lec-indy3-vga/pc-2.0-classic/"

# Check if the target directory exists
if [ -d "$target_directory" ]; then
    echo "Directory $target_directory already exists. Skipping installation."
else
    # Use DREAMM in portable mode
    touch config.json

    # Directory doesn't exist, proceed with the installation
    yes | ./dreamm -install "."

    # Check if the installation was successful
    if [ $? -eq 0 ]; then
        echo "Installation completed successfully."
    else
        echo "Installation failed."
    fi
fi

./dreamm "$target_directory"