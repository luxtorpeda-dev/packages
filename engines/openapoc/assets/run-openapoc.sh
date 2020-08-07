#!/bin/bash

ln -s ../cd.iso data
LD_LIBRARY_PATH="lib:$LD_LIBRARY_PATH" ./bin/OpenApoc
