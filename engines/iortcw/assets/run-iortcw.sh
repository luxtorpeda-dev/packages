#!/bin/bash

if ! [[ -z "${LUX_STEAM_DECK}" ]]; then
    if [ ! -f ~/.wolf/Main/wolfconfig.cfg ]; then
        if [ ! -d ~/.wolf/Main ]; then
            mkdir -p ~/.wolf/Main
        fi

        cp -rfv ./wolfconfig-template.cfg ~/.wolf/Main/wolfconfig.cfg
    fi
fi

./iowolfsp.x86_64 "$@"
