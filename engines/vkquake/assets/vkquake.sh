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
    LD_PRELOAD="" cp -rfv ./rerelease/id1/music ./share/quake/id1/music
fi

./vkquake -fitz -basedir share/quake "$@"
