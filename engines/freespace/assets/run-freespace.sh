#!/bin/bash

if [ ! -f fs1.vp ]; then
    gunzip fs1.vp.gz
fi

LD_LIBRARY_PATH="./lib:$LD_LIBRARY_PATH" ./freespace
