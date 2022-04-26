#!/bin/bash

cd ../

chmod +x DaggerfallUnity.x86_64

ln -rsf /DF/DFCD/DAGGER/ARENA2/*.VID DF/DAGGER/ARENA2

if [[ ! -z "${DEPPATH_1070560}" ]]; then
    runtimepath="$DEPPATH_1070560"
    echo "Automatically detected runtimepath at $runtimepath"
fi

"$runtimepath/scout-on-soldier-entry-point-v2" --verbose -- ./DaggerfallUnity.x86_64
