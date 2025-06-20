#!/bin/bash

export SteamDeck=""
unset SteamDeck

LD_LIBRARY_PATH="lib:$LD_LIBRARY_PATH" ./engine-classic "$@" +vid_backend 1
