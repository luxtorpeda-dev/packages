#!/bin/bash

if [ ! -f raze-template.ini ]; then
    LD_PRELOAD="" cp -rfv ./raze-template.ini ./raze.ini
fi

mkdir ./ini
cp -rfv ./BLOOD.INI ./ini/BLOOD.INI
LD_LIBRARY_PATH="lib:$LD_LIBRARY_PATH" ./raze -cryptic -config raze.ini
