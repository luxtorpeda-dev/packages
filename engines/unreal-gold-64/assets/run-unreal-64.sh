#!/bin/bash

chmod +x ../System64/UnrealLinux.bin
cd ../System64
LD_LIBRARY_PATH="../System/lib:$LD_LIBRARY_PATH" ./UnrealLinux.bin -log
