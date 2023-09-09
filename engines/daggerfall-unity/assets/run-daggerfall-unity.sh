#!/bin/bash

# Constants
ORIGINALPWD="$PWD"
MAX_WAIT_SECONDS=300  # Maximum time to wait for the Steam Linux Runtime (adjust as needed)
STEAM_RUNTIME_PATH="$DEPPATH_1070560"
IS_TESTING="true"
TESTING_PATH="$HOME/.local/share/Steam/steamapps/common/SteamLinuxRuntime/"

cd ../

chmod +x DaggerfallUnity.x86_64

if [ ! -d DFUPDATED ]; then
    mkdir -p DFUPDATED/DAGGER
    LD_PRELOAD="" cp -rfv ./DF/DAGGER ./DFUPDATED
    LD_PRELOAD="" ln -rsf DF/DFCD/DAGGER/ARENA2/*.VID DFUPDATED/DAGGER/ARENA2
fi

# Function to check if the Steam Linux Runtime is installed
is_runtime_installed() {
    if [[ ! -z "${STEAM_RUNTIME_PATH}" && -d "${STEAM_RUNTIME_PATH}" ]]; then
        return 0  # Runtime found
    else
        return 1  # Runtime not found
    fi
}

# Function to install the Steam Linux Runtime silently
install_runtime() {
    echo "Installing the Steam Linux Runtime..."
    steam "steam://dev/console/ +app_install 1070560" >/dev/null 2>&1
}

# Check if in testing mode and set the runtime path accordingly
if [[ "$IS_TESTING" == "true" ]]; then
    STEAM_RUNTIME_PATH="$TESTING_PATH"
fi

# Install the Steam Linux Runtime if not already installed
if ! is_runtime_installed; then
    echo "Steam Linux Runtime is not installed. Installing now..."
    install_runtime

    # Check for the Steam Linux Runtime in a loop
    start_time=$(date +%s)
    while true; do
        if is_runtime_installed; then
            break  # Runtime found, exit the loop
        else
            current_time=$(date +%s)
            elapsed_time=$((current_time - start_time))

            if [ "$elapsed_time" -ge "$MAX_WAIT_SECONDS" ]; then
                echo "Timeout: Steam Linux Runtime installation took too long."
                exit 1
            else
                echo "Waiting for Steam Linux Runtime installation..."
                sleep 5  # Adjust the sleep interval as needed
            fi
        fi
    done
fi

# The Steam Linux Runtime is successfully installed
echo "Steam Linux Runtime is installed and ready."

if [ ! -f ~/.config/unity3d/Daggerfall\ Workshop/Daggerfall\ Unity/settings.ini ]; then
    if [ ! -d ~/.config/unity3d/Daggerfall\ Workshop/Daggerfall\ Unity ]; then
        LD_PRELOAD="" mkdir -p ~/.config/unity3d/Daggerfall\ Workshop/Daggerfall\ Unity
    fi
    LD_PRELOAD="" echo "No settings.ini file detected, so creating"

    LD_PRELOAD="" echo -e "[Daggerfall]" >> ~/.config/unity3d/Daggerfall\ Workshop/Daggerfall\ Unity/settings.ini
    LD_PRELOAD="" echo -e "MyDaggerfallPath = ./DFUPDATED/DAGGER" >> ~/.config/unity3d/Daggerfall\ Workshop/Daggerfall\ Unity/settings.ini
fi

"$STEAM_RUNTIME_PATH/scout-on-soldier-entry-point-v2" --verbose -- ./DaggerfallUnity.x86_64
