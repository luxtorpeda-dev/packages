#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
echo $DIR

export LD_LIBRARY_PATH="$DIR/dlib:$DIR/common-qt5/lib:$LD_LIBRARY_PATH"
QT_QPA_PLATFORM_PLUGIN_PATH="$DIR/common-qt5/plugins" "$DIR/bin/doomsday" -fullscreen -imusic fluidsynth -isfx openal "$@"
