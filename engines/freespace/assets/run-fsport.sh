#!/bin/bash

if [ -f "last_error.txt" ]; then
    rm last_error.txt
fi

if [[ ! -z "${DEPPATH_273620}" ]]; then
    echo "Automatic path for freespace 2 found at $DEPPATH_273620"

    if [ ! -f "$DEPPATH_273620/fs2_open_x64" ]; then
        error_message="Freespace 2 not found or not launched."
        echo "$error_message" > last_error.txt
        exit 10
    fi
else
    error_message="Freespace 2 path not found."
    echo "$error_message" > last_error.txt
    exit 10
fi


if [ ! -d "$DEPPATH_273620/fsport" ]; then
    ln -s $PWD/fsport "$DEPPATH_273620/fsport"
fi

cd "$DEPPATH_273620"

ln -rsf ./fsport/fsport3_6.vp ./fsport3_6.vp
ln -rsf ./fsport/fsport-missions.vp ./fsport-missions.vp
ln -rsf ./fsport/sparky_hi_fs1.vp ./sparky_hi_fs1.vp

LD_LIBRARY_PATH="lib:$LD_LIBRARY_PATH" ./fs2_open_x64 "$@"

rm ./fsport3_6.vp
rm ./fsport-missions.vp
rm ./sparky_hi_fs1.vp
