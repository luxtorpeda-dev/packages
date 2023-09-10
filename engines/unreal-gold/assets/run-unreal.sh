#!/bin/bash

if [ -f "last_error.txt" ]; then
    rm last_error.txt
fi

if [ ! -f ../System/UnrealLinux.bin ]
then
    error_message="Unreal Linux not found. Please see System/README.txt for instructions in game directory."
    echo "$error_message" > last_error.txt
    exit 10
fi

chmod +x ../System/UnrealLinux.bin
cd ../System
LD_LIBRARY_PATH="../System/lib:$LD_LIBRARY_PATH" ./UnrealLinux.bin -log
