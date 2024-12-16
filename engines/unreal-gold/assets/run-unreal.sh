#!/bin/bash

chmod +x ../System/unreal-bin-x86
cd ../System
LD_LIBRARY_PATH="../System/lib:$LD_LIBRARY_PATH" ./unreal-bin-x86 -log
