#!/bin/bash

originalpwd="$PWD"
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
cd "$DIR"

rm -rf ./TFTD
ln -rsf "$originalpwd/TFD" ./TFTD

LD_LIBRARY_PATH=./lib:$LD_LIBRARY_PATH ./openxcom --data ./
