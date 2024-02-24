#!/bin/bash

if [ ! -d ezquake/share/quake/id1/music ] ; then
    LD_PRELOAD="" ln -rsf ./rerelease/id1/music ./ezquake/share/quake/id1/music
fi

if [ ! -e ezquake/share/quake/id1/pak0.pak ] ; then
    echo "id1 pak0.pak link broken"
    if [ -f Id1/PAK0.PAK ] ; then
        echo "Found Id1/PAK0.PAK"
        LD_PRELOAD="" ln -rsf ./Id1/PAK0.PAK ./ezquake/share/quake/id1/pak0.pak
        LD_PRELOAD="" ln -rsf ./Id1/PAK1.PAK ./ezquake/share/quake/id1/pak1.pak
    fi
fi

if [ ! -d ezquake/share/quake/rogue/music ] ; then
    LD_PRELOAD="" ln -rsf ./rerelease/rogue/music ./ezquake/share/quake/rogue/music
fi

if [ ! -d ezquake/share/quake/hipnotic/music ] ; then
    LD_PRELOAD="" ln -rsf ./rerelease/hipnotic/music ./ezquake/share/quake/hipnotic/music
fi

mkdir -p ./ezquake/share/quake/ezquake/share/
ln -rsf ./ezquake/share/quake/ ./ezquake/share/quake/ezquake/share

LD_LIBRARY_PATH="$LD_LIBRARY_PATH:./ezquake/lib:./lib" ./ezquake/ezquake-linux-x86_64 -basedir ezquake/share/quake "$@"
