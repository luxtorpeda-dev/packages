#!/bin/bash

export CNC_GENERALS_INSTALLPATH=$PWD
export LD_LIBRARY_PATH=lib
export LD_BIND_NOW=1

ln -rsf lib/libfreetype.so lib/libfreetyped.so.6

./RTS -win
