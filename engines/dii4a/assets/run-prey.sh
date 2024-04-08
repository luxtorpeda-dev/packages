#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

ln -rsf /lib/x86_64-linux-gnu/libopenal.so.1 ./libopenal.so

mkdir base
cp -rfv libpreygame.so preybase/libgame.so
cp -rfv libgame.so base/libgame.so

./Prey +set s_useOpenAL 1 +s_libOpenAL ./libopenal.so
