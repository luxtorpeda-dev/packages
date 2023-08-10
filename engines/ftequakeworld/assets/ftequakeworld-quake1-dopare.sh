#!/bin/bash

if [ ! -d id1/music ] ; then
    LD_PRELOAD="" ln -rsf ./rerelease/id1/music ./id1/music
fi

if [ ! -d rogue/music ] ; then
    LD_PRELOAD="" ln -rsf ./rerelease/rogue/music ./rogue/music
fi

if [ ! -d hipnotic/music ] ; then
    LD_PRELOAD="" ln -rsf ./rerelease/hipnotic/music ./hipnotic/music
fi

if [ ! -d dopare ] ; then
    LD_PRELOAD="" ln -rsf ./rerelease/dopa ./dopare
fi

chmod +x fteqw-sdl2
./fteqw-sdl2 "$@"
