#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

export LD_LIBRARY_PATH="$DIR/lib:$LD_LIBRARY_PATH"

if [ ! -f ~/.config/doomseeker/doomseeker.ini ]; then
    if [ ! -d ~/.config/doomseeker ]; then
        mkdir -p ~/.config/doomseeker
    fi
    echo "doomseeker.ini file not detected, so creating"
    cp -rfv "$DIR/doomseeker.ini" ~/.config/doomseeker/doomseeker.ini
fi

if [[ $(ldd "$DIR/doomseeker" | grep "libpulse-mainloop-glib.so.0 => not found") ]]; then
    echo "missing libpulse"
    ln -rsf "$DIR/lib/libQt5Concurrent.so" "$DIR/lib/libpulse-mainloop-glib.so.0"
else
    echo "no workaround needed"
fi

QT_QPA_PLATFORM_PLUGIN_PATH="$DIR/plugins" "$DIR/doomseeker" "$@"
