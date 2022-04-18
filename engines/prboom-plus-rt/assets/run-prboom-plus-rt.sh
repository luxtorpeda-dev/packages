#!/bin/bash

cd ./prboom-plus-rt

LD_LIBRARY_PATH="lib:$LD_LIBRARY_PATH" ./prboom-plus "$@"
