#!/bin/bash

cp -rfv ./libSDL-1.2.id.so.0 ./linuxdata/bin/Linux/x86_64

cd linuxdata
LD_LIBRARY_PATH="./bin/Linux/x86_64" ./bin/Linux/x86_64/quake4smp.x86
