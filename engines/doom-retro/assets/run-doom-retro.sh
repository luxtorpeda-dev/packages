#!/bin/bash

cd ./doom-retro

if [[ -z "${SDL_SOUNDFONTS}" ]]; then
    echo "Setting default soundfont"
    export SDL_SOUNDFONTS="fluid-soundfont-3.1/FluidR3_GM.sf2"
fi

export LD_LIBRARY_PATH="lib:$LD_LIBRARY_PATH"
./doomretro "$@"
