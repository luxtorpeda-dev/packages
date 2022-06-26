#!/bin/bash

if ! [[ -z "${LUX_STEAM_DECK}" ]]; then
    if [ ! -f ~/.config/Pyrodactyl/Good\ Robot/settings.ini ]; then
        if [ ! -d ~/.config/Pyrodactyl/Good\ Robot ]; then
            mkdir -p ~/.config/Pyrodactyl/Good\ Robot
        fi
        echo -e "[settings]" >> ~/.config/Pyrodactyl/Good\ Robot/settings.ini
        echo -e "fullscreen=1" >> ~/.config/Pyrodactyl/Good\ Robot/settings.ini
        echo -e "setup=1" >> ~/.config/Pyrodactyl/Good\ Robot/settings.ini
        echo -e "[window]" >> ~/.config/Pyrodactyl/Good\ Robot/settings.ini
        echo -e "height=800" >> ~/.config/Pyrodactyl/Good\ Robot/settings.ini
        echo -e "width=1280" >> ~/.config/Pyrodactyl/Good\ Robot/settings.ini
    fi
fi

LD_LIBRARY_PATH="lib:$LD_LIBRARY_PATH" ./good_robot
