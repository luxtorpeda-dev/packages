#!/bin/bash

# SETUP PHASE
KEYRING=/usr/share/keyrings/nodesource.gpg
curl -fsSL https://deb.nodesource.com/gpgkey/nodesource.gpg.key | gpg --dearmor | sudo tee "$KEYRING" >/dev/null
gpg --no-default-keyring --keyring "$KEYRING" --list-keys

VERSION=node_16.x
DISTRO="buster"

echo "deb [signed-by=$KEYRING] https://deb.nodesource.com/$VERSION $DISTRO main" | sudo tee /etc/apt/sources.list.d/nodesource.list
echo "deb-src [signed-by=$KEYRING] https://deb.nodesource.com/$VERSION $DISTRO main" | sudo tee -a /etc/apt/sources.list.d/nodesource.list

sudo apt-get update
sudo apt-get install nodejs

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
cp -rfv ./assets/* "$diststart/1518810/dist"
