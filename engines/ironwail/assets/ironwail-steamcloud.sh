#!/bin/bash

echo "Running non re-release"
LD_LIBRARY_PATH="$LD_LIBRARY_PATH:./ironwail/lib:./lib" ./ironwail/ironwail -basedir . "$@"
