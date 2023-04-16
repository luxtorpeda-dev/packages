#!/bin/bash

# CLONE PHASE
git clone https://github.com/chermenin/REminiscence.git
pushd REminiscence
git checkout -f e846387
popd

# BUILD PHASE
pushd REminiscence
make
popd

# COPY PHASE
cp -rfv REminiscence/fb "$diststart/961620/dist/fb"

cp -rfv assets/* "$diststart/961620/dist/"
