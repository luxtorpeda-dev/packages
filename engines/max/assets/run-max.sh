#!/bin/bash

cd max
export LD_LIBRARY_PATH="lib:$LD_LIBRARY_PATH"
./max "$@"
