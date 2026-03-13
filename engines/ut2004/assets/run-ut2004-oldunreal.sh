#!/bin/bash

if [ -f "last_error.txt" ]; then
    rm last_error.txt
fi

cd ../ # game tries to start in system directory, so have to get out and back to the normal directory

cd linuxdata-oldunreal-v2/System

./UT2004
