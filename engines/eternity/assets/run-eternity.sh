#!/bin/bash

if [[ -z "${SDL_SOUNDFONTS}" ]]; then
    echo "Setting default soundfont"
    export SDL_SOUNDFONTS="fluid-soundfont-3.1/FluidR3_GM.sf2"
fi


cd eternity

# workaround for libopengl
mkdir lib
cp /overrides/lib/x86_64-linux-gnu/libXext.so.6 lib/libOpenGL.so.0

LD_LIBRARY_PATH="lib:$LD_LIBRARY_PATH" ./eternity "$@"
