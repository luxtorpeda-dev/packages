#!/bin/bash

if [ ! -e ./data/ARENA ]; then
  ln -rs ../ARENA ./data/ARENA
fi

LD_LIBRARY_PATH="lib:$LD_LIBRARY_PATH" ./otesa
