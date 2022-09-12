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

if [ ! -f ./openmw.cfg ]; then
    echo "No openmw.cfg file detected, so creating and adding resources"
    echo -e "resources=\"share/games/openmw/resources\"\n" > ./openmw.cfg
    echo "Now running iniimporter"
    ./openmw-iniimporter ./Morrowind.ini ./openmw.cfg
    echo "Now adding data path"
    echo -e "data=\"$ORIGINALPWD/Data Files\"" >> ./openmw.cfg
    echo -e "fallback-archive=Morrowind.bsa" >> ./openmw.cfg
    echo -e "fallback-archive=Tribunal.bsa" >> ./openmw.cfg
    echo -e "fallback-archive=Bloodmoon.bsa" >> ./openmw.cfg
    echo -e "content=Morrowind.esm" >> ./openmw.cfg
    echo -e "content=Tribunal.esm" >> ./openmw.cfg
    echo -e "content=Bloodmoon.esm" >> ./openmw.cfg
    echo -e "content=builtin.omwscripts" >> ./openmw.cfg
    echo -e "config=local-cfg" >> ./openmw.cfg
else
    echo "openmw.cfg file detected, so checking for resources"
    if grep -q resources ./openmw.cfg; then
        echo "resources line found"
    else
        echo "Adding resources line"
        echo -e "\nresources=\"share/games/openmw/resources\"" >> ./openmw.cfg
    fi

    if grep -q config ./openmw.cfg; then
        echo "config line found"
    else
        echo "Adding config line"
        echo -e "\nconfig=local-cfg" >> ./openmw.cfg
    fi

    if grep -q builtin.omwscripts ./openmw.cfg; then
        echo "builtin.omwscripts"
    else
        echo "Adding builtin.omwscripts line"
        echo -e "content=builtin.omwscripts" >> ./openmw.cfg
    fi
fi

if [ ! -f ./settings.cfg ]; then
    echo -e "[Shadows]\n" > ./settings.cfg
    echo -e "enable shadows = true" >> ./settings.cfg
fi

if ! [[ -z "${LUX_STEAM_DECK}" ]]; then
    if [ ! -f ./settings.cfg ]; then
        echo -e "[Video]" >> ./settings.cfg
        echo -e "fullscreen = true" >> ./settings.cfg
        echo -e "resolution x = 1280" >> ./settings.cfg
        echo -e "resolution y = 800" >> ./settings.cfg
    fi
fi

if [ ! -f ./local-cfglauncher.cfg ]; then
    if [ -f ./launcher.cfg ]; then
        LD_PRELOAD="" ln -rsf ./launcher.cfg ./local-cfglauncher.cfg
    fi
fi

if [ ! -d ./local-cfg ]; then
    mkdir ./local-cfg
fi

if [ ! -f ./local-cfg/settings.cfg ]; then
    if [ -f ./settings.cfg ]; then
        LD_PRELOAD="" ln -rsf ./settings.cfg ./local-cfg/settings.cfg
    fi
fi

if [ ! -f ./local-cfg/input_v3.xml ]; then
    if [ -f ./input_v3.xml ]; then
        LD_PRELOAD="" ln -rsf ./input_v3.xml ./local-cfg/input_v3.xml
    fi
fi

if [ ! -f ./local-cfg/global_storage.bin ]; then
    if [ -f ./global_storage.bin ]; then
        LD_PRELOAD="" ln -rsf ./global_storage.bin ./local-cfg/global_storage.bin
    fi
fi

if [ ! -f ./local-cfg/player_storage.bin ]; then
    if [ -f ./player_storage.bin ]; then
        LD_PRELOAD="" ln -rsf ./player_storage.bin ./local-cfg/player_storage.bin
    fi
fi

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

if [ ! -d ./config/openmw ]; then
    LD_PRELOAD="" mkdir -p ./config/openmw
fi

if [ -f ./local-cfglauncher.cfg ]; then
    rm ./config/openmw/launcher.cfg
    ln -rsf ./local-cfglauncher.cfg ./config/openmw/launcher.cfg
fi

LD_LIBRARY_PATH=./lib:$LD_LIBRARY_PATH QT_QPA_PLATFORM_PLUGIN_PATH=./plugins XDG_CONFIG_HOME="./config" XDG_DATA_HOME="./local" ./openmw-launcher --data-local "../Data Files" "$@"
