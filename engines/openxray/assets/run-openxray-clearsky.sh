#!/bin/bash

rm -rf ./gamedata/configs/ui
rm -rf ./gamedata/scripts
sed -i "s/game_mode = cop/game_mode = cs/" ./gamedata/configs/openxray.ltx

cp -r ./gamedata-mods/* ./gamedata

ln -rsf /lib/x86_64-linux-gnu/libncurses.so.5.9 ./lib/libncurses.so.6

LD_LIBRARY_PATH="lib:$LD_LIBRARY_PATH" LD_AUDIT="" ./xr_3da -fsltx fsgame.ltx "$@"
