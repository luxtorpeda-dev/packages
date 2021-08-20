#!/bin/bash

if [ ! -f quakespasm/share/quake/id1/config.cfg ] ; then
	cp -f quakespasm/share/quake/default.lux.cfg quakespasm/share/quake/id1/config.cfg
	sed -i "s|%USER%|$USER|" quakespasm/share/quake/id1/config.cfg
fi

if [ ! -d quakespasm/share/quake/id1/music ] ; then
    LD_PRELOAD="" ln -rsf ./rerelease/id1/music ./quakespasm/share/quake/id1/music
fi

if [ ! -f quakespasm/share/quake/rogue/config.cfg ] ; then
	cp -f quakespasm/share/quake/default.lux.cfg quakespasm/share/quake/rogue/config.cfg
	sed -i "s|%USER%|$USER|" quakespasm/share/quake/rogue/config.cfg
fi

if [ ! -d quakespasm/share/quake/rogue/music ] ; then
    LD_PRELOAD="" ln -rsf ./rerelease/rogue/music ./quakespasm/share/quake/rogue/music
fi

if [ ! -f quakespasm/share/quake/hipnotic/config.cfg ] ; then
	cp -f quakespasm/share/quake/default.lux.cfg quakespasm/share/quake/hipnotic/config.cfg
	sed -i "s|%USER%|$USER|" quakespasm/share/quake/hipnotic/config.cfg
fi

if [ ! -d quakespasm/share/quake/hipnotic/music ] ; then
    LD_PRELOAD="" ln -rsf ./rerelease/hipnotic/music ./quakespasm/share/quake/hipnotic/music
fi

if [ ! -f quakespasm/share/quake/dopa/config.cfg ] ; then
	cp -f quakespasm/share/quake/default.lux.cfg quakespasm/share/quake/dopa/config.cfg
	sed -i "s|%USER%|$USER|" quakespasm/share/quake/dopa/config.cfg
fi

if [ ! -f quakespasm/share/quake/mg1/config.cfg ] ; then
	cp -f quakespasm/share/quake/default.lux.cfg quakespasm/share/quake/mg1/config.cfg
	sed -i "s|%USER%|$USER|" quakespasm/share/quake/mg1/config.cfg
fi

LD_LIBRARY_PATH="$LD_LIBRARY_PATH:./quakespasm/lib" ./quakespasm/quakespasm -fitz -basedir quakespasm/share/quake "$@"
