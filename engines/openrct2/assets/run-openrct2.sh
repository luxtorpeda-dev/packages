#!/bin/bash

if [ ! -d "Data" ]; then
    LD_PRELOAD="" echo "Data directory not found, assuming steam installed it as 'data'"
    LD_PRELOAD="" ln -rsf ./data ./Data
fi

LD_LIBRARY_PATH="lib:$LD_LIBRARY_PATH" LD_PRELOAD="" ./openrct2
