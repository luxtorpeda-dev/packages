#!/bin/bash

# CLONE PHASE
git clone https://github.com/OSS-Cosmic/AmnesiaTheDarkDescent.git source
pushd source
git checkout -f "$COMMIT_TAG"
popd

# COPY PHASE
cp -rfv "assets/"* "$diststart/57300/dist"
