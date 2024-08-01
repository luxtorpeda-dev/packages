#!/bin/bash

cd ../ # game tries to start in system directory, so have to get out and back to the normal directory

if [ -f ~/.ut2004/System/User.ini ]; then
    echo "detected user user.ini"

    if grep -Fxq "InputClass=Class'foxWSFix.foxPlayerInput'" ~/.ut2004/System/User.ini
    then
        echo "foxWSFix found"
    else
        echo "foxWSFix not found"
        echo -e "\n\n[XGame.xPlayer]\nInputClass=Class'foxWSFix.foxPlayerInput'" >> ~/.ut2004/System/User.ini
    fi

    sed -i "s/InputClass=Class'Engine.PlayerInput'/InputClass=Class'foxWSFix.foxPlayerInput'/" ~/.ut2004/System/User.ini
fi

cd linuxdata/System
./ut2004-bin-linux-amd64 $*
