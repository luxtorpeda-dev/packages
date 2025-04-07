#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

export LD_LIBRARY_PATH="$DIR/lib:$LD_LIBRARY_PATH"

if [ ! -f ~/.config/DoomRunner/options.json ]; then
    if [ ! -d ~/.config/DoomRunner ]; then
        mkdir -p ~/.config/DoomRunner
    fi
    echo "options.json file detected, so creating"
    cp -rfv "$DIR/options-template.json" ~/.config/DoomRunner/options.json
fi

"$DIR/DoomRunner" "$@"
