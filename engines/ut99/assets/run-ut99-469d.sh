#!/bin/bash

cd ..

cd linuxdata-469d

LD_LIBRARY_PATH="System:$LD_LIBRARY_PATH"

ldd ./System64/ut-bin
LD_AUDIT="" ./System64/ut-bin
