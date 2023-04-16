#!/bin/bash

LD_PRELOAD="$LD_PRELOAD:/overrides/lib/i386-linux-gnu/libXext.so.6" ./etl.i386 "$@"
