#!/bin/bash

rm -rf ./squashfs-root


chmod +x TiberianDawnHD-release-20250330-x86_64.AppImage
LD_LIBRARY_PATH="" ./TiberianDawnHD-release-20250330-x86_64.AppImage --appimage-extract
./squashfs-root/AppRun
