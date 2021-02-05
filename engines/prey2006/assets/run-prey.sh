#!/bin/bash

cd linuxdata

PREY_DATA_PATH="."

export ORIG_LD_LIBRARY_PATH="$LD_LIBRARY_PATH"

LD_LIBRARY_PATH=.:${PREY_DATA_PATH}:${LD_LIBRARY_PATH}
export LD_LIBRARY_PATH

exec "./prey.x86" "$@"
