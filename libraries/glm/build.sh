#!/bin/bash

# CLONE PHASE
git clone https://github.com/g-truc/glm glm
pushd glm
git checkout -f bf71a83
git submodule update --init --recursive
popd

# BUILD PHASE
export glmlocation="$PWD/glm"
