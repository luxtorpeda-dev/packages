#!/bin/bash

originalpwd="$PWD"
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
cd "$DIR"

rm -rf ./share/openxcom/UFO
ln -rsf "$originalpwd/XCOM" ./share/openxcom/UFO

if ! [[ -z "${LUX_STEAM_DECK}" ]]; then
    if [ ! -f ~/.config/openxcom/options.cfg ]; then
        if [ ! -d ~/.config/openxcom ]; then
            mkdir -p ~/.config/openxcom
        fi
        echo "No options.cfg file detected, so creating"
        echo -e "options:" >> ~/.config/openxcom/options.cfg
        echo -e "  displayHeight: 800" >> ~/.config/openxcom/options.cfg
        echo -e "  displayWidth: 1280" >> ~/.config/openxcom/options.cfg
        echo -e "  fullscreen: false" >> ~/.config/openxcom/options.cfg
    fi
fi

LD_LIBRARY_PATH=./lib:$LD_LIBRARY_PATH ./openxcom --data ./share/openxcom
