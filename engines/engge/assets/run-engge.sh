#!/bin/bash

originalpwd="$PWD"
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
cd "$DIR"

LD_LIBRARY_PATH=".:$LD_LIBRARY_PATH" ./rott
