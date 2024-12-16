#!/bin/bash

chmod +x ../System/UnrealLinux.bin
cd ../System
LD_LIBRARY_PATH="../System/lib:$LD_LIBRARY_PATH" ./UnrealLinux.bin -log
