#!/bin/bash

LD_LIBRARY_PATH="lib:$LD_LIBRARY_PATH" LD_PRELOAD="lib/libGLEW.so" ./xr_3da -fsltx fsgame.ltx "$@"
