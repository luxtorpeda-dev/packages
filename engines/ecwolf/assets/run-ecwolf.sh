#!/bin/bash

if [ -d "base" ]; then
    cp -rfv ./ecwolf ./base
    cp -rfv ./ecwolf.pk3 ./base
    cd base
    ./ecwolf --config ecwolf.cfg
else
    ./ecwolf --config ecwolf.cfg
fi

