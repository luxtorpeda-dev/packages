#!/bin/bash

# CLONE PHASE
git clone https://github.com/dxx-rebirth/dxx-rebirth.git source
pushd source
git checkout -f 366b048879d62a3096357509fc856dde1abfb7ff
popd

# BUILD PHASE
pushd source
scons sdl2=1
popd

# COPY PHASE
cp -rfv source/build/d1x-rebirth/d1x-rebirth "$diststart/273570/dist/"
cp -rfv source/build/d2x-rebirth/d2x-rebirth "$diststart/273580/dist/"

cp -rfv assets/run-d1x.sh "$diststart/273570/dist/"
cp -rfv assets/run-d2x.sh "$diststart/273580/dist/"
