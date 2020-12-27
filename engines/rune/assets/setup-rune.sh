#!/bin/bash

cd ../

rm linuxdata/System/Rune.ini
cp System/Default.ini linuxdata/Default.ini
cp linuxdata/System/Default.ini Rune.ini
cp System/libSDL-1.2.so.0 linuxdata/System
