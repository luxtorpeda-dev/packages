#!/bin/bash

chmod +x Godot_v3.5.2-stable_x11.64
echo "1388770" > steam_appid.txt
LD_LIBRARY_PATH=.:addons/godotsteam/x11/:$LD_LIBRARY_PATH ./Godot_v3.5.2-stable_x11.64 --main-pack crueltysquad.pck
