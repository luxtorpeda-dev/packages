#!/bin/bash

ln -rsf d2xr-sc55-music.dxa ./descent2/d2xr-sc55-music.dxa
HOGDIR=./descent2
LD_LIBRARY_PATH="lib:$LD_LIBRARY_PATH" ./d2x-redux -hogdir "$HOGDIR"

