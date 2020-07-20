#!/bin/bash

GAMENAME="tr1"

mkdir -p ./data/"$GAMENAME"

cat ./GAME.DAT | head -n 3 >> ./GAME.cue
./bchunk ./GAME.GOG ./GAME.cue TRACK
./xorriso -osirrox on -indev TRACK01.iso -extract / ./data/"$GAMENAME"

mv ./data/"$GAMENAME"/DATA ./data/"$GAMENAME"/data
rm TRACK01.iso
