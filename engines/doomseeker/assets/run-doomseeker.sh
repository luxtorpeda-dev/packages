#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

export LD_LIBRARY_PATH="$DIR/lib:$LD_LIBRARY_PATH"

QT_QPA_PLATFORM_PLUGIN_PATH="$DIR/plugins" "$DIR/doomseeker" "$@"
