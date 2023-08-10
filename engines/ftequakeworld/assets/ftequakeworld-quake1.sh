#!/bin/bash

if [ ! -e id1/pak0.pak ] ; then
    echo "id1 pak0.pak not found"
    if [ -f Id1/PAK0.PAK ] ; then
        echo "Found Id1/PAK0.PAK"
        LD_PRELOAD="" mkdir ./id1
        LD_PRELOAD="" ln -rsf ./Id1/PAK0.PAK ./id1/pak0.pak
        LD_PRELOAD="" ln -rsf ./Id1/PAK1.PAK ./id1/pak1.pak
    fi
fi

if [ ! -d id1/music ] ; then
    LD_PRELOAD="" ln -rsf ./rerelease/id1/music ./id1/music
fi

if [ ! -d rogue/music ] ; then
    LD_PRELOAD="" ln -rsf ./rerelease/rogue/music ./rogue/music
fi

if [ ! -d hipnotic/music ] ; then
    LD_PRELOAD="" ln -rsf ./rerelease/hipnotic/music ./hipnotic/music
fi

chmod +x fteqw-sdl2
./fteqw-sdl2 "$@"
