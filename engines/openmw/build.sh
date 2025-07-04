#!/bin/bash

# CLONE PHASE
git clone https://github.com/OpenMW/openmw source

git clone https://github.com/zesterer/openmw-shaders.git openmw-shaders

# COPY PHASE
cp assets/* "$diststart/22320/dist/"
mkdir -p "$diststart/22320/dist/openmw-shaders"
cp -rfv openmw-shaders/shaders/* "$diststart/22320/dist/openmw-shaders"
