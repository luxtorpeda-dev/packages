#!/bin/bash

if [ ! -f Gothic.ini ]; then
    cp system/GOTHIC.INI Gothic.ini
fi

LD_LIBRARY_PATH="lib:$LD_LIBRARY_PATH" ./bin/Gothic2Notr -g1 -g . -nofrate
