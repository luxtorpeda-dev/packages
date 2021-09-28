#!/bin/bash

ln -s ../cd.iso data

if [ ! -f extractready ]; then
    LD_LIBRARY_PATH="lib:$LD_LIBRARY_PATH" ./bin/OpenApoc_DataExtractor
    touch extractready
fi

LD_LIBRARY_PATH="lib:$LD_LIBRARY_PATH" QT_QPA_PLATFORM_PLUGIN_PATH=./plugins ./bin/OpenApoc_Launcher
