#!/bin/bash

mkdir -p linuxdata

cd linuxdata

ln -rsf ../Scenes.rte Scenes.rte
ln -rsf ../Metagames.rte Metagames.rte
ln -rsf Base.rte/Craft/DropShips Base.rte/Craft/Dropships
ln -rsf Techion.rte/Devices/Weapons/NanoRifle/Nanorifle.ini Techion.rte/Devices/Weapons/NanoRifle/NanoRifle.ini
ln -rsf Techion.rte/Devices/Weapons/NanoRifle/NanorifleSight.lua Techion.rte/Devices/Weapons/NanoRifle/NanoRifleSight.lua
ln -rsf Techion.rte/Devices/Weapons/NanoRifle/Sounds/NanoshotExplode1.wav Techion.rte/Devices/Weapons/NanoRifle/Sounds/NanoShotExplode1.wav
ln -rsf Dummy.rte/Craft/DropShips Dummy.rte/Craft/Dropships

LD_LIBRARY_PATH="lib:$LD_LIBRARY_PATH" ./CCCP.x86_64 "$@"
