#!/bin/bash

ORIGINALDIR="$PWD"
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

cd "$DIR"

LD_PRELOAD="" ln -rsf "$ORIGINALDIR/etmain/pak0.pk3" ./etmain/pak0.pk3
LD_PRELOAD="" ln -rsf "$ORIGINALDIR/etmain/pak1.pk3" ./etmain/pak1.pk3
LD_PRELOAD="" ln -rsf "$ORIGINALDIR/etmain/pak2.pk3" ./etmain/pak2.pk3
LD_PRELOAD="" ln -rsf "$ORIGINALDIR/etmain/mp_bin.pk3" ./etmain/mp_bin.pk3

./ete.x86 "$@"
