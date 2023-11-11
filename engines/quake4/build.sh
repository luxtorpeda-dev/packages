#!/bin/bash

# COPY PHASE
cp -rfv "$pfx/lib/libSDL-1.2.so.1.2.60" "$diststart/2210/dist/libSDL-1.2.id.so.0"
cp -rfv "assets/run-quake4.sh" "$diststart/2210/dist/"
cp -rfv "assets/setup-quake4.sh" "$diststart/2210/dist/"
cp -rfv "assets/uninstall-quake4.sh" "$diststart/2210/dist/"
cp -rfv "assets/Quake4Config.cfg" "$diststart/2210/dist/"
