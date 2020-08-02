#!/bin/bash

ln -s ../cd.iso data
LD_LIBRARY_PATH="lib:qt5/lib:$LD_LIBRARY_PATH" QT_QPA_PLATFORM_PLUGIN_PATH=./qt5/plugins ./bin/OpenApoc_Launcher
