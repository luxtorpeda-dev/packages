#!/bin/bash

chmod +x ../System64/unreal-bin-amd64
cd ../System64
LD_LIBRARY_PATH="../System/lib:$LD_LIBRARY_PATH" ./unreal-bin-amd64 -log
