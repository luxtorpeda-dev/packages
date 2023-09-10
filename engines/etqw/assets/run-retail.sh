#!/bin/bash

if [ ! -f full/etqw-rthread ]; then
    error_message="Retail version not in correct location."
    echo "$error_message" > last_error.txt
    exit 10
fi

cd ./full
cp -rfv ../libSDL-1.2.so.0 ./libSDL-1.2.id.so.0
./etqw-rthread
