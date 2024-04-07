#!/bin/bash

export SteamDeck=""
unset SteamDeck

export LD_LIBRARY_PATH="lib:$LD_LIBRARY_PATH"

chmod +x CleanDoom.x86_64

./CleanDoom.x86_64 "$@"
