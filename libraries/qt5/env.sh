#!/bin/bash

export LIBRARY_LICENSES="./source/LICENSE.LGPLv3 ./source/LICENSE.GPLv3 ./source/LICENSE.FDL"
export LIBRARY_COPY_TO_DIST="$pfx/qt5/*"
export LIBRARY_COPY_TO_LIB="$pfx/usr/local/lib/*.so* $pfx/usr/local/lib/x86_64-linux-gnu/*.so*"
