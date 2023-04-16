#!/bin/bash

chmod +x TiberianDawnHD-release-20230225-x86_64.AppImage
LD_LIBRARY_PATH="" ./TiberianDawnHD-release-20230225-x86_64.AppImage --appimage-extract
./squashfs-root/AppRun
