#!/bin/bash

cd ./dsda-doom

LD_LIBRARY_PATH="lib:$LD_LIBRARY_PATH" ./dsda-doom "$@"
