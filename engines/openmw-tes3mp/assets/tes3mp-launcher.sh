#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

cd "$DIR"

export LD_LIBRARY_PATH="lib":$LD_LIBRARY_PATH

set -e

if [ ! -f "openmw.cfg" ]; then
    cp openmw-template.cfg openmw.cfg
fi

./openmw-iniimporter ../Morrowind.ini openmw.cfg

LD_LIBRARY_PATH=../qt5/lib:$LD_LIBRARY_PATH QT_QPA_PLATFORM_PLUGIN_PATH=../qt5/plugins ./openmw-launcher "$@" 
