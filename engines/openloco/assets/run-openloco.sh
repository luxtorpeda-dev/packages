#!/bin/bash

if [ ! -f ~/.config/OpenLoco/openloco.yml ] 
then
    mkdir -p ~/.config/OpenLoco
    echo "loco_install_path: ./" > ~/.config/OpenLoco/openloco.yml
fi

./openloco
