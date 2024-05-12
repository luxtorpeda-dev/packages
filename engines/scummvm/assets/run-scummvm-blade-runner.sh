#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
GAME="$1"
OPTIONS="$2"
INIPATH="scummvm.ini"

cd "$DIR"

if [ ! -f "$INIPATH" ]; then
    echo "Creating $INIPATH"
    echo -e "[scummvm]\ngfx_mode=opengl" > "$INIPATH"
fi

if [[ $DIR == *"ScummVM"* ]]; then
    echo "Running parent path"
    PATH_ARG="--path=../../../"
else
    echo "Running normal path"
    PATH_ARG="--path=../Classic"
fi

ln -rsf ./share/scummvm/shaders ../shaders

LD_LIBRARY_PATH="lib:$LD_LIBRARY_PATH" ./bin/scummvm -c "$INIPATH" --add $PATH_ARG --recursive

LD_LIBRARY_PATH="lib:$LD_LIBRARY_PATH" ./bin/scummvm -c "$INIPATH" --fullscreen --themepath=./share/scummvm
