#!/bin/bash

gamearg="$1"

echo "ASDASD"
echo "$PWD"

if [ -z $1 ]; then
    ./nblood -usecwd -nosetup
elif [ "$gamearg" = "-addon" ]; then
    ln -rsf "addons/Cryptic Passage/tiles007.ART" "addons/Cryptic Passage/TILES007.ART"
    ln -rsf "addons/Cryptic Passage/tiles015.ART" "addons/Cryptic Passage/TILES015.ART"
    ./nblood -usecwd -nosetup -ini "addons/Cryptic Passage/CRYPTIC.INI" -j "addons/Cryptic Passage"
else
    ./nblood -usecwd -nosetup
fi
