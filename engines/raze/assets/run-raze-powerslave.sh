#!/bin/bash

gamearg="$1"

if [ ! -f raze-template.ini ]; then
    LD_PRELOAD="" cp -rfv ./raze-template.ini ./raze.ini
fi

LD_LIBRARY_PATH="lib:$LD_LIBRARY_PATH" ./raze -gamegrp PWRSLAVE/STUFF.DAT -config raze.ini
