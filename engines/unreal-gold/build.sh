#!/bin/bash

# COPY PHASE
cp -rfv "$pfx/lib64/libSDL-1.2.so.1.2.60" "$diststart/13250/dist/libSDL-1.2.so.0"
cp -rfv assets/* "$diststart/13250/dist/"
