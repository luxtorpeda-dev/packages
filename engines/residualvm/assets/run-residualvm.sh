#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
cd "$DIR"

ln -rsf ./share/residualvm/shaders ../shaders

LD_LIBRARY_PATH="lib:$LD_LIBRARY_PATH" ./bin/residualvm --add --path=../ --recursive
LD_LIBRARY_PATH="lib:$LD_LIBRARY_PATH" ./bin/residualvm --fullscreen --themepath=./share/residualvm
