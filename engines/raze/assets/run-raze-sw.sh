#!/bin/bash

gamearg="$1"

if [ -z $1 ]; then
    LD_LIBRARY_PATH="lib:$LD_LIBRARY_PATH" ./raze -gamegrp gameroot/SW.GRP
elif [ "$gamearg" = "-addon1" ]; then
    LD_LIBRARY_PATH="lib:$LD_LIBRARY_PATH" ./raze -gamegrp gameroot/addons/WT.GRP
elif [ "$gamearg" = "-addon2" ]; then
    LD_LIBRARY_PATH="lib:$LD_LIBRARY_PATH" ./raze -gamegrp gameroot/addons/TD.grp
fi
