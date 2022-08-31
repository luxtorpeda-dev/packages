#!/bin/bash

cd cnq3

mkdir ./baseq3
mkdir ./missionpack

ln -rsf ../baseq3/pak*.pk3 ./baseq3
ln -rsf ../missionpack/pak*.pk3 ./missionpack
ln -rsf ../baseq3/q3key ./baseq3/q3key

LD_LIBRARY_PATH="./lib:$LD_LIBRARY_PATH" ./cnq3-x64 "$@"
