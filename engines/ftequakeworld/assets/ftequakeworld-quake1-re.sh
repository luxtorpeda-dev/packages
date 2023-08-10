#!/bin/bash

if [ ! -d id1re ] ; then
    LD_PRELOAD="" ln -rsf ./rerelease/id1 ./id1re
fi

if [ ! -d roguere ] ; then
    LD_PRELOAD="" ln -rsf ./rerelease/rogue ./roguere
fi

if [ ! -d hipnoticre ] ; then
    LD_PRELOAD="" ln -rsf ./rerelease/hipnotic ./hipnoticre
fi

chmod +x fteqw-sdl2

if [[ "$*" == *rerelease* ]]
then
    gamearg="$2"
    echo "Running re-release $2"
    if [ -z "$2" ]
    then
        echo "Running id1re"
        ./fteqw-sdl2 -game id1re "$@"
    else
        expansionname="${gamearg//-}"
        echo "Running mission pack $expansionname"
        ./fteqw-sdl2 -game "${expansionname}re" "$@"
    fi
else
    echo "Running non re-release"
    ./fteqw-sdl2 "$@"
fi
