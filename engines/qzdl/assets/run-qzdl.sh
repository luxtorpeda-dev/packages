#!/bin/bash

ORIGINALDIR="$PWD"
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

export LD_LIBRARY_PATH="$DIR/lib:$LD_LIBRARY_PATH"

if [ ! -f "$DIR/qZDL.ini" ]; then
    echo -e "[zdl.ports]\n" > "$DIR/qZDL.ini"
    echo -e "p0n=GZDoom\n" >> "$DIR/qZDL.ini"
    echo -e "p0f=$ORIGINALDIR/run-gzdoom.sh\n" >> "$DIR/qZDL.ini"
fi

"$DIR/zdl"
