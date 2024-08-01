#!/bin/bash

export SteamDeck=""
unset SteamDeck

LD_LIBRARY_PATH="lib:$LD_LIBRARY_PATH" ./rfgzdoom "$@"
