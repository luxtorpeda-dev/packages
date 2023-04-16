#!/bin/bash

export LIBRARY_LICENSES="./source/LICENSE.LGPLv3 ./source/LICENSE.GPLv3 ./source/LICENSE.FDL xcb-util-0.4.1/COPYING libxkbcommon/LICENSE xcb-util-wm-0.4.2/COPYING xcb-util-image-0.4.1/COPYING xcb-util-keysyms-0.4.1/COPYING xcb-util-renderutil-0.3.10/COPYING"
export LIBRARY_COPY_TO_DIST="$pfx/qt5/*"
export LIBRARY_COPY_TO_LIB="$pfx/usr/local/lib/*.so* $pfx/usr/local/lib/x86_64-linux-gnu/*.so*"
