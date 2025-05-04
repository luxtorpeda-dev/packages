#!/bin/bash

if [ ! -f doom_complete.pk3 ]; then
    cd wadsmoosh-branch-default
    cp -rfv ../wadsmoosh.py ./

    cp -rfv ../masterbase/master/wads/*.WAD "source_wads/"
    cp -rfv ../base/*.WAD "source_wads/"
    python3.9 wadsmoosh.py
    cp -rfv ./doom_complete.pk3 ../

    cd ../
fi

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

export LD_LIBRARY_PATH="$DIR/lib:$LD_LIBRARY_PATH"

"$DIR/DoomRunner" "$@"
