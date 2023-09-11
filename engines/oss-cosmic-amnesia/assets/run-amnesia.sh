#!/bin/bash

chmod +x Amnesia

cp -rfv ./lib/libIL.so ./lib/libIL.so.1

LD_LIBRARY_PATH="lib:$LD_LIBRARY_PATH" ./Amnesia "$@"
