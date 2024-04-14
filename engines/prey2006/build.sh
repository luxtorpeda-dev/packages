#!/bin/bash

# COPY PHASE
cp -rfv "$pfx/lib/libSDL-1.2.so.1.2.52" "$diststart/3970/dist/libSDL-1.2.so.0"
cp -rfv "assets/run-prey.sh" "$diststart/3970/dist/"
cp -rfv "assets/setup-prey.sh" "$diststart/3970/dist/"
cp -rfv "assets/uninstall-prey.sh" "$diststart/3970/dist/"
