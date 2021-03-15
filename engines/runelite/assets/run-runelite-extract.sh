#!/bin/bash

chmod +x RuneLite.AppImage
LD_LIBRARY_PATH="" ./RuneLite.AppImage --appimage-extract
./squashfs-root/RuneLite
