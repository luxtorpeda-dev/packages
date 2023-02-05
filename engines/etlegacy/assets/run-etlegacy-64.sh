#!/bin/bash

ORIGINALDIR="$PWD"
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

cd "$DIR"

LD_PRELOAD="" ln -rsf "$ORIGINALDIR/etmain/pak0.pk3" ./etmain/pak0.pk3
LD_PRELOAD="" ln -rsf "$ORIGINALDIR/etmain/pak1.pk3" ./etmain/pak1.pk3
LD_PRELOAD="" ln -rsf "$ORIGINALDIR/etmain/pak2.pk3" ./etmain/pak2.pk3

LD_PRELOAD="$LD_PRELOAD:/overrides/lib/x86_64-linux-gnu/libXext.so.6" ./etl.x86_64 "$@"
