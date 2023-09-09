if [ -f "last_error.txt" ]; then
    rm last_error.txt
fi

# Function to check if an app is installed based on DEPPATH
function is_app_installed() {
    local app_id="$1"
    local deppath_var="DEPPATH_${app_id}"

    if [[ ! -z "${!deppath_var}" ]]; then
        return 0  # The app is installed
    else
        return 1  # The app is not installed
    fi
}

# Install Source SDK Base 2013 Singleplayer if not already installed
if [[ ! -z "${DEPPATH_243730}" ]]; then
    echo "Installing Source SDK Base 2013 Singleplayer..."
    steam "steam://dev/console/ +app_install 243730"

    # Wait for the installation to complete
    while ! is_app_installed 243730; do
        sleep 5
    done

    echo "Source SDK Base 2013 Singleplayer installed."
fi

# Install Steam Linux Runtime if not already installed
if ! is_app_installed 1070560; then
    echo "Installing Steam Linux Runtime..."
    steam "steam://dev/console/ +app_install 1070560"

    # Wait for the installation to complete
    while ! is_app_installed 1070560; do
        sleep 5
    done

    echo "Steam Linux Runtime installed."
fi

if [ ! -f "sdkpath.txt" ]; then
    if [[ ! -z "${DEPPATH_243730}" ]]; then
        echo "Automatic path for sdk found at $DEPPATH_243730"
        HL_PATH="$DEPPATH_243730"
    else
        "$STEAM_ZENITY" --info --text="Browse to Source SDK Base 2013 Singleplayer Installation" --title="Information"
        HL_PATH=$("$STEAM_ZENITY" --file-selection --title="Browse to Source SDK Base 2013 Singleplayer Installation" --directory)

        if [ -z "$HL_PATH" ]; then
            error_message="Path to Source SDK 2013 not given."
            if [[ -z "${LUX_ERRORS_SUPPORTED}" ]]; then
                "$STEAM_ZENITY" --error --title="Error" --text="$error_message"
            else
                echo "$error_message" > last_error.txt
            fi
            exit 10
        fi

        if [ ! -d "$HL_PATH/sdktools" ]; then
            error_message="Path to Source SDK 2013 incorrect."
            if [[ -z "${LUX_ERRORS_SUPPORTED}" ]]; then
                "$STEAM_ZENITY" --error --title="Error" --text="$error_message"
            else
                echo "$error_message" > last_error.txt
            fi
            exit 10
        fi
    fi

    echo "$HL_PATH" >> sdkpath.txt

    pushd "downfall"
        # from https://steamcommunity.com/sharedfiles/filedetails/?id=754991349&insideModal=0
        LD_PRELOAD="" find ./ | LD_PRELOAD="" sort -r | LD_PRELOAD="" sed 's/\(.*\/\)\(.*\)/mv "\1\2" "\1\L\2"/' | LD_PRELOAD="" sh
    popd
fi

if [ ! -f "runtimepath.txt" ]; then
    if [[ ! -z "${DEPPATH_1070560}" ]]; then
        echo "Automatic path for runtime found at $DEPPATH_1070560"
        RUNTIME_PATH="$DEPPATH_1070560"
    else
        "$STEAM_ZENITY" --info --text="Browse to Steam Linux Runtime Installation. You should see a scout-on-soldier-entry-point-v2 file in the proper directory." --title="Information"
        RUNTIME_PATH=$("$STEAM_ZENITY" --file-selection --title="Browse to Steam Linux Runtime Installation." --directory)

        if [ -z "$RUNTIME_PATH" ]; then
            error_message="Path to Steam Linux Runtime not given."
            if [[ -z "${LUX_ERRORS_SUPPORTED}" ]]; then
                "$STEAM_ZENITY" --error --title="Error" --text="$error_message"
            else
                echo "$error_message" > last_error.txt
            fi
            exit 10
        fi

        if [ ! -f "$RUNTIME_PATH/scout-on-soldier-entry-point-v2" ]; then
            error_message="Path to Steam Linux Runtime incorrect."
            if [[ -z "${LUX_ERRORS_SUPPORTED}" ]]; then
                "$STEAM_ZENITY" --error --title="Error" --text="$error_message"
            else
                echo "$error_message" > last_error.txt
            fi
            exit 10
        fi
    fi

    echo "$RUNTIME_PATH" >> runtimepath.txt
fi

pushd "downfall"
    LD_PRELOAD="" cp -rfv ../gameinfo.txt gameinfo.txt
popd

if [[ ! -z "${DEPPATH_243730}" ]]; then
    sdkpath="$DEPPATH_243730"
    echo "Automatically detected sdkpath at $sdkpath"
else
    sdkpath=$(cat sdkpath.txt)
fi

if [[ ! -z "${DEPPATH_1070560}" ]]; then
    runtimepath="$DEPPATH_1070560"
    echo "Automatically detected runtimepath at $runtimepath"
else
    runtimepath=$(cat runtimepath.txt)
fi

"$runtimepath/scout-on-soldier-entry-point-v2" --verbose -- "$sdkpath"/hl2.sh -game "$PWD/downfall" -steam +mat_hdr_level "2"
