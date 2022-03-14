#!/bin/bash

gamearg="$1"
gamenum="$2"

if [ -z $1 ]; then
    ./netduke32 -usecwd -nosetup
elif [ "$gamenum" = "1" ]; then
    ./netduke32 -j addons/dc -usecwd -nosetup -addon 1
elif [ "$gamenum" = "2" ]; then
    ./netduke32 -j addons/nw -usecwd -nosetup -addon 2
elif [ "$gamenum" = "3" ]; then
    ./netduke32 -j addons/vacation -usecwd -nosetup -addon 3
else
    ./netduke32 -usecwd -nosetup
fi
