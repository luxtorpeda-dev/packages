#!/bin/bash

# Default config.cfg files for both Steam version of Quake and for
# vkQuake are really bad.
#
# TODO: detect screen resolution, because vkQuake's desktop resolution
#       mode and default resolution detection are broken.
#
if [ ! -f share/quake/dopa/config.cfg ] ; then
	cp -f share/quake/default.lux.cfg share/quake/dopa/config.cfg
	sed -i "s|%USER%|$USER|" share/quake/dopa/config.cfg
fi

if [ ! -f share/quake/mg1/config.cfg ] ; then
	cp -f share/quake/default.lux.cfg share/quake/mg1/config.cfg
	sed -i "s|%USER%|$USER|" share/quake/mg1/config.cfg
fi

./vkquake -fitz -basedir share/quake "$@"
