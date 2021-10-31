#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
cd "$DIR"

if [[ -d "../Original" ]]; then
    echo "Assuming original path for scummvm"
    LD_LIBRARY_PATH="lib:$LD_LIBRARY_PATH" ./bin/scummvm --add --path=../Original --recursive
else
    LD_LIBRARY_PATH="lib:$LD_LIBRARY_PATH" ./bin/scummvm --add --path=../ --recursive
fi


LD_LIBRARY_PATH="lib:$LD_LIBRARY_PATH" ./bin/scummvm --fullscreen --gfx-mode=opengl --themepath=./share/scummvm
