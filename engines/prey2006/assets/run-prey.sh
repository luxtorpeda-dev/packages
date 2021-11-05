#!/bin/bash

cd linuxdata

PREY_DATA_PATH="."

export ORIG_LD_LIBRARY_PATH="$LD_LIBRARY_PATH"

LD_LIBRARY_PATH=.:${PREY_DATA_PATH}:${LD_LIBRARY_PATH}
export LD_LIBRARY_PATH

mkdir -p ~/.prey/base
cp -rfv ../autoexec.cfg ~/.prey/base

exec "./prey.x86" "$@"
