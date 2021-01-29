#!/bin/bash

if [ ! -f quakespasm/share/quake/rogue/config.cfg ] ; then
	cp -f quakespasm/share/quake/default.lux.cfg quakespasm/share/quake/rogue/config.cfg
	sed -i "s|%USER%|$USER|" quakespasm/share/quake/rogue/config.cfg
fi

LD_LIBRARY_PATH="$LD_LIBRARY_PATH:./quakespasm/lib" ./quakespasm/quakespasm -fitz -basedir quakespasm/share/quake -game rogue "$@"
