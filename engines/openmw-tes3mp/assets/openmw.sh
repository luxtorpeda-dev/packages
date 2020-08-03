#!/bin/bash

export LD_LIBRARY_PATH=lib:$LD_LIBRARY_PATH

set -e

if [ ! -f "openmw.cfg" ]; then
    cp openmw-template.cfg openmw.cfg
fi

./openmw-iniimporter Morrowind.ini openmw.cfg

./openmw --data-local "Data Files" "$@" 
