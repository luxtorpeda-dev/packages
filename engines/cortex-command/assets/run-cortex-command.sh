#!/bin/bash

mkdir -p linuxdata

cd linuxdata

ln -rsf ../Scenes.rte Scenes.rte
ln -rsf ../Metagames.rte Metagames.rte
ln -rsf Base.rte/Craft/DropShips Base.rte/Craft/Dropships
ln -rsf Techion.rte/Devices/Weapons/Nanorifle.ini Techion.rte/Devices/Weapons/NanoRifle.ini
ln -rsf Techion.rte/Devices/Weapons/NanorifleSight.lua Techion.rte/Devices/Weapons/NanoRifleSight.lua
ln -rsf Techion.rte/Effects/Sounds/NanoshotExplode.wav Techion.rte/Effects/Sounds/NanoShotExplode.wav
ln -rsf Dummy.rte/Craft/DropShips Dummy.rte/Craft/Dropships

LD_LIBRARY_PATH="lib:$LD_LIBRARY_PATH" ./CortexCommand "$@"
