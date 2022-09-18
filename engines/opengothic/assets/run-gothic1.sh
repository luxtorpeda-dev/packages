#!/bin/bash

cd ..

if [ ! -f Gothic.ini ]; then
    cp system/GOTHIC.INI Gothic.ini
fi

LD_LIBRARY_PATH="system/lib:$LD_LIBRARY_PATH" ./system/bin/Gothic2Notr -g1 -g . -nofrate
