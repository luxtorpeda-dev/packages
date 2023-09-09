#!/bin/bash

ORIGINALPWD="$PWD"

cd ../

chmod +x DaggerfallUnity.x86_64

if [ ! -d DFUPDATED ]; then
    mkdir -p DFUPDATED/DAGGER
    LD_PRELOAD="" cp -rfv ./DF/DAGGER ./DFUPDATED
    LD_PRELOAD="" ln -rsf DF/DFCD/DAGGER/ARENA2/*.VID DFUPDATED/DAGGER/ARENA2
fi

# Maximum time to wait for installation in seconds (adjust as needed)
timeout=600  # Change this to your preferred timeout value

# Check if Steam Linux Runtime 1.0 (scout) is installed
if [[ ! -z "${DEPPATH_1070560}" ]]; then
    runtimepath="$DEPPATH_1070560"
    LD_PRELOAD="" echo "Automatically detected runtimepath at $runtimepath"
else
    # Steam Linux Runtime 1.0 (scout) is not installed, so let's install it
    echo "Steam Linux Runtime 1.0 (scout) is not installed. Installing..."

    # Start the installation in the background
    steam "steam://dev/console/ +app_install 1070560" &

    # Initialize a timer
    start_time=$(date +%s)

    # Check for the runtimepath in a loop until the installation is complete or times out
    while true; do
        # Check if the installation is complete
        if [[ ! -z "${DEPPATH_1070560}" ]]; then
            runtimepath="$DEPPATH_1070560"
            LD_PRELOAD="" echo "Installed Steam Linux Runtime 1.0 (scout) at $runtimepath"
            break
        fi

        # Check if the timeout has been reached
        current_time=$(date +%s)
        elapsed_time=$((current_time - start_time))

        if [[ $elapsed_time -ge $timeout ]]; then
            echo "Timeout: Steam Linux Runtime 1.0 (scout) installation took too long."
            echo "Please ensure that it is installed manually and try again." > last_error.txt
            exit 10
        fi

        # Sleep for a short duration before checking again
        sleep 2
    done
fi

if [ ! -f ~/.config/unity3d/Daggerfall\ Workshop/Daggerfall\ Unity/settings.ini ]; then
    if [ ! -d ~/.config/unity3d/Daggerfall\ Workshop/Daggerfall\ Unity ]; then
        LD_PRELOAD="" mkdir -p ~/.config/unity3d/Daggerfall\ Workshop/Daggerfall\ Unity
    fi
    LD_PRELOAD="" echo "No settings.ini file detected, so creating"

    LD_PRELOAD="" echo -e "[Daggerfall]" >> ~/.config/unity3d/Daggerfall\ Workshop/Daggerfall\ Unity/settings.ini
    LD_PRELOAD="" echo -e "MyDaggerfallPath = ./DFUPDATED/DAGGER" >> ~/.config/unity3d/Daggerfall\ Workshop/Daggerfall\ Unity/settings.ini
fi

"$runtimepath/scout-on-soldier-entry-point-v2" --verbose -- ./DaggerfallUnity.x86_64
