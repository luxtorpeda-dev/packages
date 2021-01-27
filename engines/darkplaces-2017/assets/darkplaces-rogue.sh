#!/bin/bash

if [ ! -f darkplaces-2017/share/quake/rogue/config.cfg ] ; then
	cp -f darkplaces-2017/share/quake/default.lux.cfg darkplaces-2017/share/quake/rogue/config.cfg
	sed -i "s|%USER%|$USER|" darkplaces-2017/share/quake/rogue/config.cfg
fi

./darkplaces-2017/darkplaces-sdl -basedir darkplaces-2017/share/quake -game rogue "$@"
