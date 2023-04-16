#!/bin/bash

if [ ! -f rl2211 ]; then
    LD_LIBRARY_PATH=.7z ./7z/7z x ./runescape-launcher_2.2.11_amd64.deb
    tar xvf data.tar
    touch rl2211
fi

./usr/share/games/runescape-launcher/runescape --configURI http://www.runescape.com/k=5/l=\$\(Language:0\)/jav_config.ws
