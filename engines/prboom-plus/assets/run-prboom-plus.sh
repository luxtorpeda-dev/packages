#!/bin/bash

cd ./prboom-plus

LD_LIBRARY_PATH="lib:$LD_LIBRARY_PATH" ./prboom-plus "$@"
