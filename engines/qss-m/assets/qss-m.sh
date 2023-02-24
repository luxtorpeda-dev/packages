#!/bin/bash

if [ ! -f qss-m/share/quake/id1/config.cfg ] ; then
	cp -f qss-m/share/quake/default.lux.cfg qss-m/share/quake/id1/config.cfg
	sed -i "s|%USER%|$USER|" qss-m/share/quake/id1/config.cfg
fi

if [ ! -d qss-m/share/quake/id1/music ] ; then
    LD_PRELOAD="" ln -rsf ./rerelease/id1/music ./qss-m/share/quake/id1/music
fi

if [ ! -e qss-m/share/quake/id1/pak0.pak ] ; then
    echo "id1 pak0.pak link broken"
    if [ -f Id1/PAK0.PAK ] ; then
        echo "Found Id1/PAK0.PAK"
        LD_PRELOAD="" ln -rsf ./Id1/PAK0.PAK ./qss-m/share/quake/id1/pak0.pak
        LD_PRELOAD="" ln -rsf ./Id1/PAK1.PAK ./qss-m/share/quake/id1/pak1.pak
    fi
fi

if [ ! -f qss-m/share/quake/rogue/config.cfg ] ; then
	cp -f qss-m/share/quake/default.lux.cfg qss-m/share/quake/rogue/config.cfg
	sed -i "s|%USER%|$USER|" qss-m/share/quake/rogue/config.cfg
fi

if [ ! -d qss-m/share/quake/rogue/music ] ; then
    LD_PRELOAD="" ln -rsf ./rerelease/rogue/music ./qss-m/share/quake/rogue/music
fi

if [ ! -f qss-m/share/quake/hipnotic/config.cfg ] ; then
	cp -f qss-m/share/quake/default.lux.cfg qss-m/share/quake/hipnotic/config.cfg
	sed -i "s|%USER%|$USER|" qss-m/share/quake/hipnotic/config.cfg
fi

if [ ! -d qss-m/share/quake/hipnotic/music ] ; then
    LD_PRELOAD="" ln -rsf ./rerelease/hipnotic/music ./qss-m/share/quake/hipnotic/music
fi

if [ ! -f qss-m/share/quake/dopa/config.cfg ] ; then
	cp -f qss-m/share/quake/default.lux.cfg qss-m/share/quake/dopa/config.cfg
	sed -i "s|%USER%|$USER|" qss-m/share/quake/dopa/config.cfg
fi

if [ ! -f qss-m/share/quake/mg1/config.cfg ] ; then
	cp -f qss-m/share/quake/default.lux.cfg qss-m/share/quake/mg1/config.cfg
	sed -i "s|%USER%|$USER|" qss-m/share/quake/mg1/config.cfg
fi

LD_LIBRARY_PATH="$LD_LIBRARY_PATH:./qss-m/lib:./lib" ./qss-m/qss-m -basedir qss-m/share/quake "$@"
