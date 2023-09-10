#!/bin/bash

# CLONE PHASE
git clone https://github.com/OSS-Cosmic/AmnesiaTheDarkDescent.git source
pushd source
git checkout -f f8f905e

# COPY PHASE
cp -rfv "assets/"* "$diststart/57300/dist"
