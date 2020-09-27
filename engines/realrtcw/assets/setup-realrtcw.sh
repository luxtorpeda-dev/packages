#!/bin/bash

ln -rsf ./Main/*.pk3 ./realrtcw/Main

cd realrtcw

LD_LIBRARY_PATH=./lib ./innoextract realrtcwcompletesetup.exe
cp -r ./app/* ./
rm -rf ./app
