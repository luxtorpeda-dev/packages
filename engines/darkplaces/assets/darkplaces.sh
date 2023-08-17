#!/bin/bash

if [ ! -f darkplaces/share/quake/id1/config.cfg ] ; then
	cp -f darkplaces/share/quake/default.lux.cfg darkplaces/share/quake/id1/config.cfg
	sed -i "s|%USER%|$USER|" darkplaces/share/quake/id1/config.cfg
fi

if [ ! -d darkplaces/share/quake/id1/music ] ; then
    LD_PRELOAD="" ln -rsf ./rerelease/id1/music ./darkplaces/share/quake/id1/music
fi

if [ ! -e darkplaces/share/quake/id1/pak0.pak ] ; then
    echo "id1 pak0.pak link broken"
    if [ -f Id1/PAK0.PAK ] ; then
        echo "Found Id1/PAK0.PAK"
        LD_PRELOAD="" ln -rsf ./Id1/PAK0.PAK ./darkplaces/share/quake/id1/pak0.pak
        LD_PRELOAD="" ln -rsf ./Id1/PAK1.PAK ./darkplaces/share/quake/id1/pak1.pak
    fi
fi

if [ ! -f darkplaces/share/quake/rogue/config.cfg ] ; then
	cp -f darkplaces/share/quake/default.lux.cfg darkplaces/share/quake/rogue/config.cfg
	sed -i "s|%USER%|$USER|" darkplaces/share/quake/rogue/config.cfg
fi

if [ ! -d darkplaces/share/quake/rogue/music ] ; then
    LD_PRELOAD="" ln -rsf ./rerelease/rogue/music ./darkplaces/share/quake/rogue/music
fi

if [ ! -f darkplaces/share/quake/hipnotic/config.cfg ] ; then
	cp -f darkplaces/share/quake/default.lux.cfg darkplaces/share/quake/hipnotic/config.cfg
	sed -i "s|%USER%|$USER|" darkplaces/share/quake/hipnotic/config.cfg
fi

if [ ! -d darkplaces/share/quake/hipnotic/music ] ; then
    LD_PRELOAD="" ln -rsf ./rerelease/hipnotic/music ./darkplaces/share/quake/hipnotic/music
fi

if [ ! -f darkplaces/share/quake/dopa/config.cfg ] ; then
	cp -f darkplaces/share/quake/default.lux.cfg darkplaces/share/quake/dopa/config.cfg
	sed -i "s|%USER%|$USER|" darkplaces/share/quake/dopa/config.cfg
fi

if [ ! -f darkplaces/share/quake/mg1/config.cfg ] ; then
	cp -f darkplaces/share/quake/default.lux.cfg darkplaces/share/quake/mg1/config.cfg
	sed -i "s|%USER%|$USER|" darkplaces/share/quake/mg1/config.cfg
fi

./darkplaces/darkplaces-sdl -basedir darkplaces/share/quake "$@"
