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

if [ ! -f share/quake/id1/music ] ; then
    LD_PRELOAD="" ln -rsf ./rerelease/id1/music ./share/quake/id1/music
fi

if [ ! -f share/quake/rogue/config.cfg ] ; then
	cp -f share/quake/default.lux.cfg share/quake/rogue/config.cfg
	sed -i "s|%USER%|$USER|" share/quake/rogue/config.cfg
fi

if [ ! -f share/quake/rogue/music ] ; then
    LD_PRELOAD="" ln -rsf ./rerelease/rogue/music ./share/quake/rogue/music
fi

if [ ! -f share/quake/hipnotic/config.cfg ] ; then
	cp -f share/quake/default.lux.cfg share/quake/hipnotic/config.cfg
	sed -i "s|%USER%|$USER|" share/quake/hipnotic/config.cfg
fi

if [ ! -f share/quake/hipnotic/music ] ; then
    LD_PRELOAD="" ln -rsf ./rerelease/hipnotic/music ./share/quake/hipnotic/music
fi

if [ ! -f share/quake/dopa/config.cfg ] ; then
	cp -f share/quake/default.lux.cfg share/quake/dopa/config.cfg
	sed -i "s|%USER%|$USER|" share/quake/dopa/config.cfg
fi

if [ ! -f share/quake/mg1/config.cfg ] ; then
	cp -f share/quake/default.lux.cfg share/quake/mg1/config.cfg
	sed -i "s|%USER%|$USER|" share/quake/mg1/config.cfg
fi

./vkquake -fitz -basedir share/quake "$@"
