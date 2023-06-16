#!/bin/bash

if [ ! -d "Data" ]; then
    LD_PRELOAD="" echo "Data directory not found, assuming steam installed it as 'Assets'"
    LD_PRELOAD="" ln -rsf ./Assets ./Data
fi

LD_LIBRARY_PATH="lib:$LD_LIBRARY_PATH" LD_PRELOAD="" ./openrct2 set-rct2 . 
