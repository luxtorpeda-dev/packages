#!/bin/bash

gamearg="$1"

if [ -z $1 ]; then
    ./voidsw -usecwd -nosetup
elif [ "$gamearg" = "-addon1" ]; then
    ./voidsw -gaddons/WT.GRP -usecwd -nosetup -addon1
elif [ "$gamearg" = "-addon2" ]; then
    ./voidsw -gaddons/TD.grp -usecwd -nosetup -addon2
fi
