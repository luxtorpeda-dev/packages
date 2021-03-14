#!/bin/bash

if [ -d "base" ]; then
    cp -rfv ./ecwolf ./base
    cp -rfv ./ecwolf.pk3 ./base
    cd base
    ./ecwolf
else
    ./ecwolf
fi

