#!/bin/bash

cd ../ # game tries to start in system directory, so have to get out and back to the normal directory

if [ -f ~/.ut2004/System/User.ini ]; then
    echo "detected user user.ini"

    sed -i "s/InputClass=Class'foxWSFix.foxPlayerInput'/InputClass=Class'Engine.PlayerInput'/" ~/.ut2004/System/User.ini

    if grep -Fxq "InputClass=Class'foxWSFix.foxPlayerInput'" ~/.ut2004/System/User.ini
    then
        echo "foxWSFix found"
        sed -i "/InputClass=Class'foxWSFix.foxPlayerInput'/d" ~/.ut2004/System/User.ini
    fi
fi

cd linuxdata-standard/System
SDL12COMPAT_USE_KEYBOARD_LAYOUT=0 ./ut2004-bin-linux-amd64
