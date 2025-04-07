#!/bin/bash

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
