#!/bin/bash

if [ ! -f Gothic.ini ]; then
    cp system/Gothic.ini GOTHIC.ini
fi

LD_LIBRARY_PATH="lib:$LD_LIBRARY_PATH" ./bin/Gothic2Notr -g1 -g . -nofrate
