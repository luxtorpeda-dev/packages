#!/bin/bash

# SETUP DOTNET

curl -L https://dot.net/v1/dotnet-install.sh -o dotnet-install.sh
chmod +x ./dotnet-install.sh
./dotnet-install.sh --channel 10.0

# CLONE PHASE
git clone https://github.com/Helion-Engine/Helion.git source
pushd source
git checkout "$COMMIT_TAG"
popd

# BUILD PHASE
pushd "source/Client"
dotnet publish -c Release -r linux-x64 -p:SelfContainedRelease=true
popd

# COPY PHASE
cp -rfv source/Publish/linux-x64_SelfContained "$diststart/common/dist/helion"
cp -rfv assets/* "$diststart/common/dist/"
