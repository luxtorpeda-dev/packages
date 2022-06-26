#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

cd "$DIR"

ln -rsf ../data/sequences.wz ./data/sequences.wz

if ! [[ -z "${LUX_STEAM_DECK}" ]]; then
    if [ ! -f ~/.local/share/warzone2100/config ]; then
        if [ ! -d ~/.local/share/warzone2100 ]; then
            mkdir -p ~/.local/share/warzone2100
        fi
        echo -e "[general]" >> ~/.local/share/warzone2100/config
        echo -e "fullscreen=1" >> ~/.local/share/warzone2100/config
        echo -e "width=1280" >> ~/.local/share/warzone2100/config
        echo -e "height=800" >> ~/.local/share/warzone2100/config
    fi
fi

LD_LIBRARY_PATH=lib:$LD_LIBRARY_PATH bin/warzone2100
