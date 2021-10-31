#!/bin/bash

if [ -f "last_error.txt" ]; then
    rm last_error.txt
fi

cd linuxdata

PREY_DATA_PATH="."

export ORIG_LD_LIBRARY_PATH="$LD_LIBRARY_PATH"

LD_LIBRARY_PATH=.:${PREY_DATA_PATH}:${LD_LIBRARY_PATH}
export LD_LIBRARY_PATH

if [[ ! -z "${DEPPATH_1070560}" ]]; then
    runtimepath="$DEPPATH_1070560"
    echo "Automatically detected runtimepath at $runtimepath"
else
    error_message="Steam Linux Runtime Not Found."
    if [[ -z "${LUX_ERRORS_SUPPORTED}" ]]; then
        "$STEAM_ZENITY" --error --title="Error" --text="$error_message"
    else
        echo "$error_message" > ../last_error.txt
    fi
    exit 10
fi

"$runtimepath/scout-on-soldier-entry-point-v2" --verbose -- "./prey.x86" "$@"
