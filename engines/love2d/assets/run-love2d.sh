#!/bin/bash

chmod +x love-11.5-x86_64.AppImage
LD_LIBRARY_PATH="" ./love-11.5-x86_64.AppImage --appimage-extract
./squashfs-root/AppRun "$LUX_ORIGINAL_EXE_FILE"
