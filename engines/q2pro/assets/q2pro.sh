#!/bin/bash

cd q2pro

ln -rsf ./gamex86_64.so ./baseq2/gamex86_64.so

LD_LIBRARY_PATH="./:$LD_LIBRARY_PATH" ./q2pro +set basedir ./ +set libdir ./ "$@"
