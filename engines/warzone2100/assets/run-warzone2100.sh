#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

cd "$DIR"

ln -rsf ../data/sequences.wz ./data/sequences.wz

LD_LIBRARY_PATH=lib:$LD_LIBRARY_PATH bin/warzone2100
