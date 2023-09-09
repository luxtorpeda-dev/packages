#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
cd "$DIR"

LD_PRELOAD="" ln -rsf homeworld.big Homeworld.big
LD_PRELOAD="" ln -rsf homeworld.big Update.big

./homeworld
