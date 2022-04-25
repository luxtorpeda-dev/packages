#!/bin/bash

if [ ! -f gzdoom.ini ]; then
    cp -rfv ./gzdoom_template.ini gzdoom.ini
fi

LD_LIBRARY_PATH="lib:$LD_LIBRARY_PATH" ./gzdoom "$@"
