#!/bin/bash

cd eternity

# workaround for libopengl
mkdir lib
cp /overrides/lib/x86_64-linux-gnu/libXext.so.6 lib/libOpenGL.so.0

LD_LIBRARY_PATH="lib:$LD_LIBRARY_PATH" ./eternity "$@"
