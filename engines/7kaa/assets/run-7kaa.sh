#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
cd "$DIR"

LD_LIBRARY_PATH="lib:$LD_LIBRARY_PATH" ./7kaa
