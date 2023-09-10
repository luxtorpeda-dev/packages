#!/bin/bash

chmod +x Amnesia

LD_LIBRARY_PATH="lib:$LD_LIBRARY_PATH" ./Amnesia "$@"
