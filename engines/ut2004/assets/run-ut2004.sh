#!/bin/bash

cd ../ # game tries to start in system directory, so have to get out and back to the normal directory

if [[ ! -z "${DEPPATH_1070560}" ]]; then
    runtimepath="$DEPPATH_1070560"
    echo "Automatically detected runtimepath at $runtimepath"

    cd linuxdata/System
    "$runtimepath/scout-on-soldier-entry-point-v2" --verbose -- ./ut2004-bin-linux-amd64
else
    cd linuxdata/System
    ./ut2004-bin-linux-amd64
fi


