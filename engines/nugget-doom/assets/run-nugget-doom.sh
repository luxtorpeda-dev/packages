#!/bin/bash

cd ./nugget-doom

if [[ -z "${SDL_SOUNDFONTS}" ]]; then
    echo "Setting default soundfont"
    export SDL_SOUNDFONTS="soundfonts/TimGM6mb.sf2"
fi

export LD_LIBRARY_PATH="lib:$LD_LIBRARY_PATH"

mkdir -p ../share/nugget-doom
ln -rsf ./soundfonts ../share/nugget-doom/soundfonts

./nugget-doom "$@"
