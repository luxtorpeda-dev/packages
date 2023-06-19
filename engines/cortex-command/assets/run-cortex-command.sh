#!/bin/bash

cd linuxdata

LD_LIBRARY_PATH="lib:$LD_LIBRARY_PATH" ./CortexCommand "$@"
