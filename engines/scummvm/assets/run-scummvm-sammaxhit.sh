#!/bin/bash

ORIGINALPWD="$PWD"

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
cd "$DIR"

if [ ! -f scummvm.ini ]; then
    echo "No scummvm.ini file detected, so creating"
    echo -e "[scummvm]" >> scummvm.ini
    echo -e "gfx_mode=surfacesdl" >> scummvm.ini
fi

LD_LIBRARY_PATH="lib:$LD_LIBRARY_PATH" ./bin/scummvm -c scummvm.ini --add --path=../ --recursive

cd "$ORIGINALPWD"
cd ..

LD_LIBRARY_PATH="$ORIGINALPWD/scum/lib:$LD_LIBRARY_PATH" "$ORIGINALPWD/scum/bin/scummvm" -c "$ORIGINALPWD/scum/scummvm.ini" --fullscreen --themepath="$ORIGINALPWD/scum/share/scummvm" --add --path=.

if ! [[ -z "${LUX_STEAM_CLOUD}" ]]; then
    LD_LIBRARY_PATH="$ORIGINALPWD/scum/lib:$LD_LIBRARY_PATH" "$ORIGINALPWD/scum/bin/scummvm" -c "$ORIGINALPWD/scum/scummvm.ini" --fullscreen --themepath="$ORIGINALPWD/scum/share/scummvm" --savepath=.
else
    LD_LIBRARY_PATH="$ORIGINALPWD/scum/lib:$LD_LIBRARY_PATH" "$ORIGINALPWD/scum/bin/scummvm" -c "$ORIGINALPWD/scum/scummvm.ini" --fullscreen --themepath="$ORIGINALPWD/scum/share/scummvm"
fi
