#!/bin/bash

if [ ! -f darkplaces-2017/share/quake/id1/config.cfg ] ; then
	cp -f darkplaces-2017/share/quake/default.lux.cfg darkplaces-2017/share/quake/id1/config.cfg
	sed -i "s|%USER%|$USER|" darkplaces-2017/share/quake/id1/config.cfg
fi

if [ ! -d darkplaces-2017/share/quake/id1/music ] ; then
    LD_PRELOAD="" ln -rsf ./rerelease/id1/music ./darkplaces-2017/share/quake/id1/music
fi

if [ ! -f darkplaces-2017/share/quake/rogue/config.cfg ] ; then
	cp -f darkplaces-2017/share/quake/default.lux.cfg darkplaces-2017/share/quake/rogue/config.cfg
	sed -i "s|%USER%|$USER|" darkplaces-2017/share/quake/rogue/config.cfg
fi

if [ ! -d darkplaces-2017/share/quake/rogue/music ] ; then
    LD_PRELOAD="" ln -rsf ./rerelease/rogue/music ./darkplaces-2017/share/quake/rogue/music
fi

if [ ! -f darkplaces-2017/share/quake/hipnotic/config.cfg ] ; then
	cp -f darkplaces-2017/share/quake/default.lux.cfg darkplaces-2017/share/quake/hipnotic/config.cfg
	sed -i "s|%USER%|$USER|" darkplaces-2017/share/quake/hipnotic/config.cfg
fi

if [ ! -d darkplaces-2017/share/quake/hipnotic/music ] ; then
    LD_PRELOAD="" ln -rsf ./rerelease/hipnotic/music ./darkplaces-2017/share/quake/hipnotic/music
fi

if [ ! -f darkplaces-2017/share/quake/dopa/config.cfg ] ; then
	cp -f darkplaces-2017/share/quake/default.lux.cfg darkplaces-2017/share/quake/dopa/config.cfg
	sed -i "s|%USER%|$USER|" darkplaces-2017/share/quake/dopa/config.cfg
fi

if [ ! -f darkplaces-2017/share/quake/mg1/config.cfg ] ; then
	cp -f darkplaces-2017/share/quake/default.lux.cfg darkplaces-2017/share/quake/mg1/config.cfg
	sed -i "s|%USER%|$USER|" darkplaces-2017/share/quake/mg1/config.cfg
fi

./darkplaces-2017/darkplaces-sdl -basedir darkplaces-2017/share/quake "$@"
