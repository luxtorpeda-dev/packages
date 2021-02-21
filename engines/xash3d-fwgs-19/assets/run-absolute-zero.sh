#!/bin/bash

GAMEROOT="."
GAMEEXE="xash3d"
export LD_LIBRARY_PATH="$GAMEROOT:$LD_LIBRARY_PATH"

LC_ALL=C "${GAMEROOT}"/"${GAMEEXE}" -game AbsoluteZero -dll dlls/az.dll -clientlib cl_dlls/client.so "$@"
