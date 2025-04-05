#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

export LD_LIBRARY_PATH="$DIR/lib:$LD_LIBRARY_PATH"

if [ ! -f ~/.config/doomseeker/doomseeker.ini ]; then
    if [ ! -d ~/.config/doomseeker ]; then
        mkdir -p ~/.config/doomseeker
    fi
    echo "doomseeker.ini file not detected, so creating"
    cp -rfv "$DIR/doomseeker.ini" ~/.config/doomseeker/doomseeker.ini
fi

"$DIR/doomseeker" "$@"
