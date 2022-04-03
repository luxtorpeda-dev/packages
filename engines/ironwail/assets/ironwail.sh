#!/bin/bash

if [ ! -f ironwail/share/quake/id1/config.cfg ] ; then
	cp -f ironwail/share/quake/default.lux.cfg ironwail/share/quake/id1/config.cfg
	sed -i "s|%USER%|$USER|" ironwail/share/quake/id1/config.cfg
fi

if [ ! -d ironwail/share/quake/id1/music ] ; then
    LD_PRELOAD="" ln -rsf ./rerelease/id1/music ./ironwail/share/quake/id1/music
fi

if [ ! -e ironwail/share/quake/id1/pak0.pak ] ; then
    echo "id1 pak0.pak link broken"
    if [ -f Id1/PAK0.PAK ] ; then
        echo "Found Id1/PAK0.PAK"
        LD_PRELOAD="" ln -rsf ./Id1/PAK0.PAK ./ironwail/share/quake/id1/pak0.pak
        LD_PRELOAD="" ln -rsf ./Id1/PAK1.PAK ./ironwail/share/quake/id1/pak1.pak
    fi
fi

if [ ! -f ironwail/share/quake/rogue/config.cfg ] ; then
	cp -f ironwail/share/quake/default.lux.cfg ironwail/share/quake/rogue/config.cfg
	sed -i "s|%USER%|$USER|" ironwail/share/quake/rogue/config.cfg
fi

if [ ! -d ironwail/share/quake/rogue/music ] ; then
    LD_PRELOAD="" ln -rsf ./rerelease/rogue/music ./ironwail/share/quake/rogue/music
fi

if [ ! -f ironwail/share/quake/hipnotic/config.cfg ] ; then
	cp -f ironwail/share/quake/default.lux.cfg ironwail/share/quake/hipnotic/config.cfg
	sed -i "s|%USER%|$USER|" ironwail/share/quake/hipnotic/config.cfg
fi

if [ ! -d ironwail/share/quake/hipnotic/music ] ; then
    LD_PRELOAD="" ln -rsf ./rerelease/hipnotic/music ./ironwail/share/quake/hipnotic/music
fi

if [ ! -f ironwail/share/quake/dopa/config.cfg ] ; then
	cp -f ironwail/share/quake/default.lux.cfg ironwail/share/quake/dopa/config.cfg
	sed -i "s|%USER%|$USER|" ironwail/share/quake/dopa/config.cfg
fi

if [ ! -f ironwail/share/quake/mg1/config.cfg ] ; then
	cp -f ironwail/share/quake/default.lux.cfg ironwail/share/quake/mg1/config.cfg
	sed -i "s|%USER%|$USER|" ironwail/share/quake/mg1/config.cfg
fi

LD_LIBRARY_PATH="$LD_LIBRARY_PATH:./ironwail/lib:./lib" ./ironwail/ironwail -fitz -basedir ironwail/share/quake "$@"
