#!/bin/bash

rm ./fsport3_6.vp
rm ./fsport-missions.vp
rm ./sparky_hi_fs1.vp

LD_LIBRARY_PATH="lib:$LD_LIBRARY_PATH" ./fs2_open_x64 "$@"
