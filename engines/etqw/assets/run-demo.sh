#!/bin/bash

if [ -f "last_error.txt" ]; then
    rm last_error.txt
fi

if [ ! -f demo/etqw-rthread ]; then
    error_message="Demo version not in correct location."
    echo "$error_message" > last_error.txt
    exit 10
fi

cd ./demo
cp -rfv ../libSDL-1.2.so.0 ./libSDL-1.2.id.so.0
./etqw-rthread
