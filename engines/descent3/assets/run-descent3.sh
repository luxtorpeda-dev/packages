#!/bin/bash

export LD_LIBRARY_PATH="./lib:$LD_LIBRARY_PATH"
./Descent3-lux "$@"
