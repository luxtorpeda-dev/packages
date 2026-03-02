#!/bin/bash

rm -rf ./squashfs-root


chmod +x TiberianDawnHD-playtest-20260222-x86_64.AppImage
LD_LIBRARY_PATH="" ./TiberianDawnHD-playtest-20260222-x86_64.AppImage --appimage-extract
./squashfs-root/AppRun
