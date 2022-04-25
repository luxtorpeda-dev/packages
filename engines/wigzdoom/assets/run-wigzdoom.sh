#!/bin/bash

if [ ! -f ~/.config/wigzdoom/wigzdoom.ini ]; then
    if [ ! -d ~/.config/wigzdoom ]; then
        mkdir -p ~/.config/wigzdoom
    fi
    cp -rfv ./wigzdoom_template.ini ~/.config/wigzdoom/wigzdoom.ini
fi

LD_LIBRARY_PATH="lib:$LD_LIBRARY_PATH" ./wigzdoom "$@"
