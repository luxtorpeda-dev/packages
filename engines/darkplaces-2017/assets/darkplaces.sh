#!/bin/bash

if [ ! -f darkplaces/share/quake/id1/config.cfg ] ; then
	cp -f darkplaces/share/quake/default.lux.cfg darkplaces/share/quake/id1/config.cfg
	sed -i "s|%USER%|$USER|" darkplaces/share/quake/id1/config.cfg
fi

./darkplaces-sdl -basedir darkplaces/share/quake "$@"
