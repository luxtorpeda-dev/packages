#!/bin/bash

if [ ! -d chocolate-quake/share/quake/id1/music ] ; then
    LD_PRELOAD="" ln -rsf ./rerelease/id1/music ./chocolate-quake/share/quake/id1/music
fi

if [ ! -e chocolate-quake/share/quake/id1/pak0.pak ] ; then
    echo "id1 pak0.pak link broken"
    if [ -f Id1/PAK0.PAK ] ; then
        echo "Found Id1/PAK0.PAK"
        LD_PRELOAD="" ln -rsf ./Id1/PAK0.PAK ./chocolate-quake/share/quake/id1/pak0.pak
        LD_PRELOAD="" ln -rsf ./Id1/PAK1.PAK ./chocolate-quake/share/quake/id1/pak1.pak
    fi
fi

if [ ! -d chocolate-quake/share/quake/rogue/music ] ; then
    LD_PRELOAD="" ln -rsf ./rerelease/rogue/music ./chocolate-quake/share/quake/rogue/music
fi

if [ ! -d chocolate-quake/share/quake/hipnotic/music ] ; then
    LD_PRELOAD="" ln -rsf ./rerelease/hipnotic/music ./chocolate-quake/share/quake/hipnotic/music
fi

LD_LIBRARY_PATH="$LD_LIBRARY_PATH:./chocolate-quake/lib:./lib" ./chocolate-quake/chocolate-quake -basedir chocolate-quake/share/quake "$@"
