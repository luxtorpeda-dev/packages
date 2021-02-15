#!/bin/bash

gamearg="$1"
gamenum="$2"

if [ -z $1 ]; then
    ./eduke32 -usecwd -nosetup
elif [ "$gamenum" = "1" ]; then
    ./eduke32 -j gameroot -j gameroot/addons/dc -usecwd -nosetup -addon 1
elif [ "$gamenum" = "2" ]; then
    ./eduke32 -j gameroot -j gameroot/addons/nw -usecwd -nosetup -addon 2
elif [ "$gamenum" = "3" ]; then
    ./eduke32 -j gameroot -j gameroot/addons/vacation -usecwd -nosetup -addon 3
else
    ./eduke32 -usecwd -nosetup
fi
