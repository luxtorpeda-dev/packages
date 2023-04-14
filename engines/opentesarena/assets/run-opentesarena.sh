#!/bin/bash

ln -rsf ../ARENA ./data/ARENA

LD_LIBRARY_PATH="lib:$LD_LIBRARY_PATH" ./otesa
