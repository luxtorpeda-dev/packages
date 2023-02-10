#!/bin/bash

# CLONE PHASE
git clone https://github.com/hrehfeld/QuakeInjector source
pushd source
git checkout 4e06006
popd

# COPY PHASE

cp -rfv assets/* "$diststart/2310/dist/"
