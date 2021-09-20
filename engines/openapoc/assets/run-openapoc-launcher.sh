#!/bin/bash

ln -s ../cd.iso data
LD_LIBRARY_PATH="lib:$LD_LIBRARY_PATH" QT_QPA_PLATFORM_PLUGIN_PATH=./plugins ./bin/OpenApoc_Launcher
