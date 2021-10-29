#!/bin/bash

if [ ! -f doom_complete.pk3 ]; then
    cd wadsmoosh-branch-default
    cp -rfv ../wadsmoosh.py ./

    cp -rfv ../master/wads/*.WAD "source_wads/"
    cp -rfv ../doom2/*.WAD "source_wads/"
    python3.7 wadsmoosh.py
    cp -rfv ./doom_complete.pk3 ../

    cd ../
fi

LD_LIBRARY_PATH="lib:$LD_LIBRARY_PATH" ./gzdoom "$@"
