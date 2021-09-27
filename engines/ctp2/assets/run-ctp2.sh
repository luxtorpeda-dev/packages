#!/bin/bash

cd ctp2_program/ctp
LD_LIBRARY_PATH="../../lib:$LD_LIBRARY_PATH" LD_PRELOAD="" ./ctp2 -fullscreen
