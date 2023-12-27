#!/bin/bash

ln -rsf d1xr-sc55-music.dxa ./descent/d1xr-sc55-music.dxa
HOGDIR=./descent
LD_LIBRARY_PATH="lib:$LD_LIBRARY_PATH" ./d1x-rebirth -hogdir "$HOGDIR"

