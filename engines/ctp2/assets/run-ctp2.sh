#!/bin/bash

ln -rsf /lib/x86_64-linux-gnu/libgtk-3.so.0 ./lib/libgtk-x11-2.0.so.0

cd ctp2_program/ctp
LD_LIBRARY_PATH="../../lib:$LD_LIBRARY_PATH" LD_PRELOAD="" ./ctp2 -fullscreen
