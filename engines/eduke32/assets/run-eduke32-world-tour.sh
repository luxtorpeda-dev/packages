#!/bin/bash

gamearg="$1"
gamenum="$2"

mkdir world-tour
cd world-tour
ln -rsf ../DUKE3D.GRP DUKE3D.GRP
ln -rsf ../eduke32 eduke32

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
