#!/bin/bash

ln -rsf /lib/x86_64-linux-gnu/libncurses.so.5.9 ./lib/libncurses.so.6

LD_LIBRARY_PATH="lib:$LD_LIBRARY_PATH" LD_AUDIT="" ./xr_3da -fsltx fsgame.ltx "$@"
