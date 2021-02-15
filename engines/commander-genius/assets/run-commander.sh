#!/bin/bash

if [ ! -d ./base1/games ]; then
    mkdir -p ./base1/games
    ln -rsf ./CGeniusExe ./base1/CGeniusExe
    ln -rsf ./base2 ./base1/games/keen2
    ln -rsf ./base3 ./base1/games/keen3
    ln -rsf ./base4 ./base1/games/keen4
    ln -rsf ./base5 ./base1/games/keen5
fi

cd base1
./CGeniusExe  "$@"
