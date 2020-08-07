#!/bin/bash

LD_LIBRARY_PATH="lib:$LD_LIBRARY_PATH" ./bin/scummvm --add --recursive --fullscreen --gfx_mode=opengl "$@"
