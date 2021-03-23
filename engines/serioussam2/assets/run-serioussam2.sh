#!/bin/bash

rm Patch_02_090_591918.gro

LD_LIBRARY_PATH="$LD_LIBRARY_PATH:./Bin/Linux-Dynamic-Release" padsp ./serioussam2
