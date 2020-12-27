#!/bin/bash

cd ../

rm linuxdata/System/Rune.ini
cp System/Default.ini linuxdata/Default.ini
cp linuxdata/System/Default.ini linuxdata/System/Rune.ini
cp System/libSDL-1.2.so.0 linuxdata/System
rm System/rune%2Bhon.7z
rm linuxdata/System/rune%2Bhon.7z
