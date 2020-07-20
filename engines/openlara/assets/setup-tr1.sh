#!/bin/bash

mkdir -p ./data

cat ./GAME.DAT | head -n 3 >> ./GAME.cue
./bchunk ./GAME.GOG ./GAME.cue TRACK
./xorriso -osirrox on -indev TRACK01.iso -extract /DATA ./data

ln -rsf ./OpenLara ./data/OpenLara

rm TRACK01.iso
