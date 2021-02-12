#!/bin/bash

ln -rsf ./data1/PROGS.DAT ./data1/progs.dat
ln -rsf ./data1/PROGS2.DAT ./data1/progs2.dat
ln -rsf ./data1/Strings.txt ./data1/strings.txt
ln -rsf ./data1/Hexen.rc ./data1/hexen.rc
ln -rsf ./data1/Config.cfg ./data1/config.cfg
ln -rsf ./data1/Autoexec.cfg ./data1/autoexec.cfg

LD_LIBRARY_PATH="$LD_LIBRARY_PATH:./lib" ./glhexen2 -f "$@"
