#!/bin/bash

ORIGINALPWD="$PWD"
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

cd "$DIR"

export LD_LIBRARY_PATH=lib:$LD_LIBRARY_PATH

if [ -f "$ORIGINALPWD/last_error.txt" ]; then
    rm "$ORIGINALPWD/last_error.txt"
fi

set -e

if [ ! -f ../Morrowind.ini ]; then
    if [ ! -f ../morrowind.ini ]; then
        error_message="No morrowind ini file not found."
        if [[ -z "${LUX_ERRORS_SUPPORTED}" ]]; then
            "$STEAM_ZENITY" --error --title="Error" --text="$error_message"
        else
            echo "$error_message" > "$ORIGINALPWD/last_error.txt"
        fi
        exit 10
    else
        ln -rsf ../morrowind.ini ./Morrowind.ini
    fi
else
    ln -rsf ../"Morrowind.ini" ./"Morrowind.ini"
fi

if [ ! -f ./config/openmw/openmw.cfg ]; then
    if [ ! -d ./config/openmw ]; then
        mkdir -p ./config/openmw
    fi
    echo "No openmw.cfg file detected, so creating and adding resources"
    echo -e "resources=\"share/games/openmw/resources\"\n" > ./config/openmw/openmw.cfg
    echo "Now running iniimporter"
    ./openmw-iniimporter ./Morrowind.ini ./config/openmw/openmw.cfg
    echo "Now adding data path"
    echo -e "data=\"$ORIGINALPWD/Data Files\"" >> ./config/openmw/openmw.cfg
    echo -e "fallback-archive=Morrowind.bsa" >> ./config/openmw/openmw.cfg
    echo -e "fallback-archive=Tribunal.bsa" >> ./config/openmw/openmw.cfg
    echo -e "fallback-archive=Bloodmoon.bsa" >> ./config/openmw/openmw.cfg
    echo -e "content=Morrowind.esm" >> ./config/openmw/openmw.cfg
    echo -e "content=Tribunal.esm" >> ./config/openmw/openmw.cfg
    echo -e "content=Bloodmoon.esm" >> ./config/openmw/openmw.cfg

    if ! [[ -z "${LUX_STEAM_DECK}" ]]; then
        if [ ! -f ./config/openmw/settings.cfg ]; then
            echo -e "[Video]" >> ./config/openmw/settings.cfg
            echo -e "fullscreen = true" >> ./config/openmw/settings.cfg
            echo -e "resolution x = 1280" >> ./config/openmw/settings.cfg
            echo -e "resolution y = 800" >> ./config/openmw/settings.cfg
        fi
    fi
else
    echo "openmw.cfg file detected, so checking for resources"
    if grep -q resources ./config/openmw/openmw.cfg; then
        echo "resources line found"
    else
        echo "Adding resources line"
        echo -e "\nresources=\"share/games/openmw/resources\"" >> ./config/openmw/openmw.cfg
    fi
fi

LD_PRELOAD="" ln -rsf ./config/openmw/openmw.cfg openmw.cfg

if [ ! -d ./shaders-bkup ]; then
    LD_PRELOAD="" cp -rfv ./share/games/openmw/resources/shaders ./shaders-bkup
fi

if [ "$1" == "withshaders" ]; then
    LD_PRELOAD="" echo "detected asking for shaders"

    LD_PRELOAD="" rm -rf ./newshaders
    LD_PRELOAD="" mkdir -p ./newshaders
    LD_PRELOAD="" cp -rfv ./shaders-bkup/* ./newshaders
    LD_PRELOAD="" cp -rfv ./openmw-shaders/* ./newshaders

    LD_PRELOAD="" rm -rf ./share/games/openmw/resources/shaders
    LD_PRELOAD="" ln -rsf ./newshaders ./share/games/openmw/resources/shaders
else
    LD_PRELOAD="" echo "detected not asking for shaders"
    LD_PRELOAD="" rm -rf ./share/games/openmw/resources/shaders
    LD_PRELOAD="" ln -rsf ./shaders-bkup ./share/games/openmw/resources/shaders
fi

LD_LIBRARY_PATH=./lib:$LD_LIBRARY_PATH QT_QPA_PLATFORM_PLUGIN_PATH=./plugins XDG_CONFIG_HOME="./config" XDG_DATA_HOME="./local" ./openmw-launcher --data-local "../Data Files" "$@"
