#!/bin/bash

gamearg="$1"

if [ -z $1 ]; then
    ./notblood -usecwd -nosetup
elif [ "$gamearg" = "-addon" ]; then
    ln -rsf "addons/Cryptic Passage/tiles007.ART" "addons/Cryptic Passage/TILES007.ART"
    ln -rsf "addons/Cryptic Passage/tiles015.ART" "addons/Cryptic Passage/TILES015.ART"
    ./notblood -usecwd -nosetup -ini CRYPTIC.INI -j "addons/Cryptic Passage"
else
    ./notblood -usecwd -nosetup
fi
