#!/bin/bash

cd ../

LD_LIBRARY_PATH=./System/7z ./System/7z/7z x -o"./" System/rune%2Bhon.7z
mv ./"rune+hon" ./linuxdata

rm linuxdata/System/Rune.ini
cp System/Default.ini linuxdata/System/Default.ini
cp System/UserTemplate.ini linuxdata/System/User.ini
cp linuxdata/System/Default.ini linuxdata/System/Rune.ini
cp System/libSDL-1.2.so.0 linuxdata/System
rm System/rune%2Bhon.7z
