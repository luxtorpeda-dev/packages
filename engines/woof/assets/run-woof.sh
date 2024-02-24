#!/bin/bash

cd ./woof

if [[ -z "${SDL_SOUNDFONTS}" ]]; then
    echo "Setting default soundfont"
    export SDL_SOUNDFONTS="soundfonts/TimGM6mb.sf2"
fi

export LD_LIBRARY_PATH="lib:$LD_LIBRARY_PATH"
./woof "$@"
