#!/bin/bash

GAMEROOT="."
GAMEEXE="xash3d"
export LD_LIBRARY_PATH="$GAMEROOT:$LD_LIBRARY_PATH"

mv ./before/liblist.gam ./before/liblist.gam.bak

LC_ALL=C "${GAMEROOT}"/"${GAMEEXE}" -game before -dll dlls/spirit.so -clientlib cl_dlls/client.so "$@"
