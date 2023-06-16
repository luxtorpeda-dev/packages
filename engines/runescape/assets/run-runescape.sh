#!/bin/bash

if [ ! -f rl2211 ]; then
    ./ar x ./runescape-launcher_2.2.11_amd64.deb
    tar xvf data.tar
    touch rl2211
fi

if [[ ! -z "${DEPPATH_1070560}" ]]; then
    runtimepath="$DEPPATH_1070560"
    LD_PRELOAD="" echo "Automatically detected runtimepath at $runtimepath"
else
    echo "Steam Linux Runtime is not installed. Please ensure that it is installed and try again." > last_error.txt
    exit 10
fi

"$runtimepath/scout-on-soldier-entry-point-v2" --verbose -- ./usr/share/games/runescape-launcher/runescape --configURI http://www.runescape.com/k=5/l=\$\(Language:0\)/jav_config.ws
