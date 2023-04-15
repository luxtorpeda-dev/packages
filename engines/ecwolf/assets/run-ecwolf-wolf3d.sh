#!/bin/bash

originalpwd="$PWD"
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
cd "$DIR"

if ! [[ -z "${LUX_STEAM_DECK}" ]]; then
    if [ ! -f ecwolf.cfg ]; then
        echo -e "Vid_FullScreen = 1;" >> ecwolf.cfg
        echo -e "FullScreenWidth = 1280;" >> ecwolf.cfg
        echo -e "FullScreenHeight = 800;" >> ecwolf.cfg
    fi
fi
./ecwolf --config ecwolf.cfg "$@"

