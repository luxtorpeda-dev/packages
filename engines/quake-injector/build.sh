#!/bin/bash

# CLONE PHASE
git clone https://github.com/hrehfeld/QuakeInjector source
pushd source
git checkout "$COMMIT_TAG"
popd

# COPY PHASE
cp -rfv assets/* "$diststart/2310/dist/"
