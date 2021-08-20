#!/bin/bash

# Default config.cfg files for both Steam version of Quake and for
# vkQuake are really bad.
#
# TODO: detect screen resolution, because vkQuake's desktop resolution
#       mode and default resolution detection are broken.
#
if [ ! -f share/quake/id1/config.cfg ] ; then
	cp -f share/quake/default.lux.cfg share/quake/id1/config.cfg
	sed -i "s|%USER%|$USER|" share/quake/id1/config.cfg
fi

if [ ! -d share/quake/id1/music ] ; then
    LD_PRELOAD="" ln -rsf ./rerelease/id1/music ./share/quake/id1/music
fi

if [ ! -f share/quake/id1re/config.cfg ] ; then
	cp -f share/quake/default.lux.cfg share/quake/id1re/config.cfg
	sed -i "s|%USER%|$USER|" share/quake/id1re/config.cfg
fi

if [ ! -d share/quake/id1re/music ] ; then
    LD_PRELOAD="" ln -rsf ./rerelease/id1/music ./share/quake/id1re/music
fi

if [ ! -f share/quake/rogue/config.cfg ] ; then
	cp -f share/quake/default.lux.cfg share/quake/rogue/config.cfg
	sed -i "s|%USER%|$USER|" share/quake/rogue/config.cfg
fi

if [ ! -d share/quake/rogue/music ] ; then
    LD_PRELOAD="" ln -rsf ./rerelease/rogue/music ./share/quake/rogue/music
fi

if [ ! -f share/quake/roguere/config.cfg ] ; then
	cp -f share/quake/default.lux.cfg share/quake/roguere/config.cfg
	sed -i "s|%USER%|$USER|" share/quake/roguere/config.cfg
fi

if [ ! -d share/quake/roguere/music ] ; then
    LD_PRELOAD="" ln -rsf ./rerelease/rogue/music ./share/quake/roguere/music
fi

if [ ! -f share/quake/hipnotic/config.cfg ] ; then
	cp -f share/quake/default.lux.cfg share/quake/hipnotic/config.cfg
	sed -i "s|%USER%|$USER|" share/quake/hipnotic/config.cfg
fi

if [ ! -d share/quake/hipnotic/music ] ; then
    LD_PRELOAD="" ln -rsf ./rerelease/hipnotic/music ./share/quake/hipnotic/music
fi

if [ ! -f share/quake/hipnoticre/config.cfg ] ; then
	cp -f share/quake/default.lux.cfg share/quake/hipnoticre/config.cfg
	sed -i "s|%USER%|$USER|" share/quake/hipnoticre/config.cfg
fi

if [ ! -d share/quake/hipnoticre/music ] ; then
    LD_PRELOAD="" ln -rsf ./rerelease/hipnotic/music ./share/quake/hipnoticre/music
fi

if [ ! -f share/quake/dopa/config.cfg ] ; then
	cp -f share/quake/default.lux.cfg share/quake/dopa/config.cfg
	sed -i "s|%USER%|$USER|" share/quake/dopa/config.cfg
fi

if [ ! -f share/quake/mg1/config.cfg ] ; then
	cp -f share/quake/default.lux.cfg share/quake/mg1/config.cfg
	sed -i "s|%USER%|$USER|" share/quake/mg1/config.cfg
fi

if [[ "$*" == *rerelease* ]]
then
    gamearg="$2"
    echo "Running re-release $2"
    if [ -z "$2" ]
    then
        echo "Running id1re"
        ./vkquake -fitz -basedir share/quake -game id1re "$@"
    else
        expansionname="${gamearg//-}"
        echo "Running mission pack $expansionname"
        ./vkquake -fitz -basedir share/quake -game "${expansionname}re" "$@"
    fi
else
    echo "Running non re-release"
    ./vkquake -fitz -basedir share/quake "$@"
fi
