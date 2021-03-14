#!/bin/bash

gamearg="$1"
gamenum="$2"

if [ -z $1 ]; then
    LD_LIBRARY_PATH="lib:$LD_LIBRARY_PATH" ./raze
elif [ "$gamenum" = "1" ]; then
    LD_LIBRARY_PATH="lib:$LD_LIBRARY_PATH" ./raze -gamegrp gameroot/addons/dc/dukedc.grp
elif [ "$gamenum" = "2" ]; then
    LD_LIBRARY_PATH="lib:$LD_LIBRARY_PATH" ./raze -gamegrp gameroot/addons/nw/nwinter.grp
elif [ "$gamenum" = "3" ]; then
    LD_LIBRARY_PATH="lib:$LD_LIBRARY_PATH" ./raze -gamegrp gameroot/addons/vacation/vacation.grp
else
    LD_LIBRARY_PATH="lib:$LD_LIBRARY_PATH" ./raze
fi
