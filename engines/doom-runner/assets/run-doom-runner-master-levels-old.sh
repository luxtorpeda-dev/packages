#!/bin/bash

if [ ! -f doom_complete.pk3 ]; then
    cd wadsmoosh-branch-default
    cp -rfv ../wadsmoosh.py ./

    cp -rfv ../master/wads/*.WAD "source_wads/"
    cp -rfv ../doom2/*.WAD "source_wads/"
    python3.9 wadsmoosh.py
    cp -rfv ./doom_complete.pk3 ../

    cd ../
fi

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

export LD_LIBRARY_PATH="$DIR/lib:$LD_LIBRARY_PATH"

if [ ! -f ~/.config/DoomRunner/options.json ]; then
    if [ ! -d ~/.config/DoomRunner ]; then
        mkdir -p ~/.config/DoomRunner
    fi
    echo "options.json file detected, so creating"
    cp -rfv "$DIR/options-template.json" ~/.config/DoomRunner/options.json
fi

QT_QPA_PLATFORM_PLUGIN_PATH="$DIR/plugins" "$DIR/DoomRunner" "$@"
