#!/bin/bash

if [ ! -f ~/.config/OpenLoco/openloco.yml ] 
then
    mkdir -p ~/.config/OpenLoco
    echo "loco_install_path: ./" > ~/.config/OpenLoco/openloco.yml
    echo "shortcuts: null" >> ~/.config/OpenLoco/openloco.yml

    if ! [[ -z "${LUX_STEAM_DECK}" ]]; then
        echo "display:" >> ~/.config/OpenLoco/openloco.yml
        echo "  mode: window" >> ~/.config/OpenLoco/openloco.yml
        echo "  window_resolution:" >> ~/.config/OpenLoco/openloco.yml
        echo "    width: 1280" >> ~/.config/OpenLoco/openloco.yml
        echo "    height: 800" >> ~/.config/OpenLoco/openloco.yml
        echo "  fullscreen_resolution:" >> ~/.config/OpenLoco/openloco.yml
        echo "    width: 1280" >> ~/.config/OpenLoco/openloco.yml
        echo "    height: 800" >> ~/.config/OpenLoco/openloco.yml
    fi
fi

./openloco
