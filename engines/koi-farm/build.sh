#!/bin/bash

# SETUP PHASE
sudo apt-get -y install curl
curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
sudo apt-get install -y nodejs

# CLONE PHASE
git clone https://github.com/jobtalle/Koi source
pushd source
git checkout -f 742b6bc
git submodule update --init --recursive
popd

# BUILD PHASE
pushd "source"
npm install
npm run build-linux-64
popd

# COPY PHASE
cp -rfv ./source/KoiFarm-linux-x64/* "$diststart/1518810/dist"
