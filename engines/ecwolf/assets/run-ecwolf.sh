#!/bin/bash

if [ -d "base" ]; then
    cp -rfv ./ecwolf ./base
    cd base
    ./ecwolf
else
    ./ecwolf
fi

