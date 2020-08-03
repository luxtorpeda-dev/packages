#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

export LD_LIBRARY_PATH="$DIR/lib":$LD_LIBRARY_PATH

set -e

if [ ! -f "$DIR/openmw.cfg" ]; then
    cp "$DIR/openmw-template.cfg" "$DIR/openmw.cfg"
fi

"$DIR/openmw-iniimporter" Morrowind.ini "$DIR/openmw.cfg"

LD_LIBRARY_PATH=./qt5/lib:$LD_LIBRARY_PATH QT_QPA_PLATFORM_PLUGIN_PATH=./qt5/plugins "$DIR"/openmw-launcher "$@" 
