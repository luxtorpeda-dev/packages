#!/bin/bash

if [ ! -f ezquake/share/quake/id1/config.cfg ] ; then
	cp -f ezquake/share/quake/default.lux.cfg ezquake/share/quake/id1/config.cfg
	sed -i "s|%USER%|$USER|" ezquake/share/quake/id1/config.cfg
fi

if [ ! -d ezquake/share/quake/id1/music ] ; then
    LD_PRELOAD="" ln -rsf ./rerelease/id1/music ./ezquake/share/quake/id1/music
fi

if [ ! -e ezquake/share/quake/id1/pak0.pak ] ; then
    echo "id1 pak0.pak link broken"
    if [ -f Id1/PAK0.PAK ] ; then
        echo "Found Id1/PAK0.PAK"
        LD_PRELOAD="" ln -rsf ./Id1/PAK0.PAK ./ezquake/share/quake/id1/pak0.pak
        LD_PRELOAD="" ln -rsf ./Id1/PAK1.PAK ./ezquake/share/quake/id1/pak1.pak
    fi
fi

if [ ! -f ezquake/share/quake/rogue/config.cfg ] ; then
	cp -f ezquake/share/quake/default.lux.cfg ezquake/share/quake/rogue/config.cfg
	sed -i "s|%USER%|$USER|" ezquake/share/quake/rogue/config.cfg
fi

if [ ! -d ezquake/share/quake/rogue/music ] ; then
    LD_PRELOAD="" ln -rsf ./rerelease/rogue/music ./ezquake/share/quake/rogue/music
fi

if [ ! -f ezquake/share/quake/hipnotic/config.cfg ] ; then
	cp -f ezquake/share/quake/default.lux.cfg ezquake/share/quake/hipnotic/config.cfg
	sed -i "s|%USER%|$USER|" ezquake/share/quake/hipnotic/config.cfg
fi

if [ ! -d ezquake/share/quake/hipnotic/music ] ; then
    LD_PRELOAD="" ln -rsf ./rerelease/hipnotic/music ./ezquake/share/quake/hipnotic/music
fi

if [ ! -f ezquake/share/quake/dopa/config.cfg ] ; then
	cp -f ezquake/share/quake/default.lux.cfg ezquake/share/quake/dopa/config.cfg
	sed -i "s|%USER%|$USER|" ezquake/share/quake/dopa/config.cfg
fi

if [ ! -f ezquake/share/quake/mg1/config.cfg ] ; then
	cp -f ezquake/share/quake/default.lux.cfg ezquake/share/quake/mg1/config.cfg
	sed -i "s|%USER%|$USER|" ezquake/share/quake/mg1/config.cfg
fi

LD_LIBRARY_PATH="$LD_LIBRARY_PATH:./ezquake/lib:./lib" ./ezquake/ezquake-linux-x86_64 -basedir ezquake/share/quake "$@"
