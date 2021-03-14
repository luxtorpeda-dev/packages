#!/bin/bash

cd ../
LD_LIBRARY_PATH="./dosbox_windows/lib:$LD_LIBRARY_PATH" ./dosbox_windows/raze -gamegrp NAM/NAM.GRP
