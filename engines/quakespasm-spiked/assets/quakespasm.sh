#!/bin/bash

if [ ! -f quakespasm/share/quake/id1/config.cfg ] ; then
	cp -f quakespasm/share/quake/default.lux.cfg quakespasm/share/quake/id1/config.cfg
	sed -i "s|%USER%|$USER|" quakespasm/share/quake/id1/config.cfg
fi

./quakespasm/quakespasm -basedir quakespasm/share/quake "$@"
