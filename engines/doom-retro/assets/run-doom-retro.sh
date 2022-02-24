#!/bin/bash

cd ./doom-retro

export LD_LIBRARY_PATH="$DIR/lib:$LD_LIBRARY_PATH"
./doomretro "$@"
