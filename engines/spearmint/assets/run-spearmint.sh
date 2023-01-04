#!/bin/bash

cd ./spearmint

ln -rsf ../baseq3/*.pk3 ./spearmint-patch-data/baseq3
ln -rsf ../missionpack/*.pk3 ./spearmint-patch-data/missionpack

if [ ! -f ~/.local/share/spearmint/baseq3/config.cfg ]; then
    if [ ! -d ~/.local/share/spearmint/baseq3 ]; then
        mkdir -p ~/.local/share/spearmint/baseq3
    fi

    cp -rfv ./config.cfg ~/.local/share/spearmint/baseq3/config.cfg
fi

if [ ! -f ~/.local/share/spearmint/missionpack/config.cfg ]; then
    if [ ! -d ~/.local/share/spearmint/missionpack ]; then
        mkdir -p ~/.local/share/spearmint/missionpack
    fi

    cp -rfv ./config.cfg ~/.local/share/spearmint/missionpack/config.cfg
fi

./spearmint/spearmint_x86_64 +set fs_cdpath "./spearmint-patch-data" +set fs_basepath "./mint-arena" "$@"
