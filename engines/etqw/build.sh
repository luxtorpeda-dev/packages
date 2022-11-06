#!/bin/bash

# COPY PHASE

cp -rfv "$pfx/lib/libSDL-1.2.so.1.2.60" "$diststart/10050/dist/libSDL-1.2.so.0"
cp -rfv assets/* "$diststart/10050/dist/"
cp -rfv "$pfx/lib/libSDL-1.2.so.1.2.60" "$diststart/10000/dist/libSDL-1.2.so.0"
cp -rfv assets/* "$diststart/10000/dist/"
