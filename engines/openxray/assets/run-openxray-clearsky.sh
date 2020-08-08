#!/bin/bash

rm -rf ./gamedata/configs/ui
rm -rf ./gamedata/scripts
sed -i "s/game_mode = cop/game_mode = cs/" ./gamedata/configs/openxray.ltx

LD_LIBRARY_PATH="lib:$LD_LIBRARY_PATH" ./xr_3da -fsltx fsgame.ltx "$@"
