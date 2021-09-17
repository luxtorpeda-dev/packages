#!/bin/bash

cd vkQuake2

LD_LIBRARY_PATH="./:$LD_LIBRARY_PATH" ./quake2 "$@"
