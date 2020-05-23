#!/bin/bash

if [ ! -f Gothic.ini ]; then
    cp system/Gothic.ini Gothic.ini
fi

./Gothic2Notr.sh -g . -nofrate
