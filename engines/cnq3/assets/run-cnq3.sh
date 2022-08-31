#!/bin/bash

cd cnq3

mkdir ./baseq3
mkdir ./missionpack

ln -rsf ../baseq3/*.pk3 ./baseq3
ln -rsf ../missionpack/*.pk3 ./missionpack

./cnq3-x64 "$@"
