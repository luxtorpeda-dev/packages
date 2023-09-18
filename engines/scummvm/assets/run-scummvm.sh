#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
GAME="$1"
OPTIONS="$2"
INIPATH="scummvm.ini"

cd "$DIR"

if [ ! -f "$INIPATH" ]; then
    echo "Creating $INIPATH"
    echo -e "[scummvm]\ngfx_mode=surfacesdl" > "$INIPATH"
fi

if [[ -d "../Original" ]]; then
    echo "Assuming original path for ScummVM"
    PATH_ARG="--path=../Original"
elif [[ $DIR == *"ScummVM_Windows"* ]]; then
    echo "Running parent path"
    PATH_ARG="--path=../../"
else
    echo "Running normal path"
    PATH_ARG="--path=../"
fi

LD_LIBRARY_PATH="lib:$LD_LIBRARY_PATH" ./bin/scummvm -c "$INIPATH" --add --recursive $PATH_ARG

LD_LIBRARY_PATH="lib:$LD_LIBRARY_PATH" ./bin/scummvm -c "$INIPATH" --fullscreen --themepath=./share/scummvm $OPTIONS $GAME