#!/bin/bash

chmod +x TiberianDawnHD-playtest-20230110-x86_64.AppImage
LD_LIBRARY_PATH="" ./TiberianDawnHD-playtest-20230110-x86_64.AppImage --appimage-extract
./squashfs-root/AppRun
