#!/bin/bash

LD_LIBRARY_PATH="lib:$LD_LIBRARY_PATH" ./xr_3da -fsltx fsgame.ltx "$@"
