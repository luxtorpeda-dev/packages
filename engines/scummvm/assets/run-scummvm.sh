#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
cd "$DIR"

if [[ -d "../Original" ]]; then
    echo "Assuming original path for scummvm"
    LD_LIBRARY_PATH="lib:$LD_LIBRARY_PATH" ./bin/scummvm --add --path=../Original --recursive
else
    if [[ $DIR == *"ScummVM_Windows"* ]]; then
        echo "Running parent path"
        LD_LIBRARY_PATH="lib:$LD_LIBRARY_PATH" ./bin/scummvm --add --path=../../ --recursive
    else
        echo "Running normal path"
        LD_LIBRARY_PATH="lib:$LD_LIBRARY_PATH" ./bin/scummvm --add --path=../ --recursive
    fi

fi


LD_LIBRARY_PATH="lib:$LD_LIBRARY_PATH" ./bin/scummvm --fullscreen --gfx-mode=opengl --themepath=./share/scummvm
