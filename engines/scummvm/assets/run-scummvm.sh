#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
cd "$DIR"

LD_LIBRARY_PATH="lib:$LD_LIBRARY_PATH" ./bin/scummvm --add --path=../ --recursive
LD_LIBRARY_PATH="lib:$LD_LIBRARY_PATH" ./bin/scummvm --fullscreen --gfx-mode=opengl --themepath=./share/scummvm
