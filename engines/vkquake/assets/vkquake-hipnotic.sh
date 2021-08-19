#!/bin/bash

# Default config.cfg files for both Steam version of Quake and for
# vkQuake are really bad.
#
# TODO: detect screen resolution, because vkQuake's desktop resolution
#       mode and default resolution detection are broken.
#
if [ ! -f share/quake/hipnotic/config.cfg ] ; then
	cp -f share/quake/default.lux.cfg share/quake/hipnotic/config.cfg
	sed -i "s|%USER%|$USER|" share/quake/hipnotic/config.cfg
fi

if [ ! -f share/quake/hipnotic/music ] ; then
    LD_PRELOAD="" cp -rfv ./rerelease/hipnotic/music ./share/quake/hipnotic/music
fi

./vkquake -fitz -basedir share/quake -game hipnotic "$@"
