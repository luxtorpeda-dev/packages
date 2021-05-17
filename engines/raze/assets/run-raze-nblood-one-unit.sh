#!/bin/bash

mkdir ./ini
cp -rfv ./BLOOD.INI ./ini/BLOOD.INI
LD_LIBRARY_PATH="lib:$LD_LIBRARY_PATH" ./raze
