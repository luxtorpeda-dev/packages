#!/bin/bash

export SteamDeck=""
unset SteamDeck

LD_LIBRARY_PATH="lib:$LD_LIBRARY_PATH" ./gzdoom "$@" +vid_backend 1
