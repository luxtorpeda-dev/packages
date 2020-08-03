#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

cd "$DIR"

ln -rsf ../data/sequences.wz ./data/sequences.wz

LD_LIBRARY_PATH=./qt5/lib:lib:$LD_LIBRARY_PATH QT_QPA_PLATFORM_PLUGIN_PATH=./qt5/plugins bin/warzone2100
