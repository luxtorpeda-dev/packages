#!/bin/bash

# CLONE PHASE
git clone https://bitbucket.org/ecwolf/ecwolf.git source
pushd source
git checkout "$COMMIT_TAG"
popd

# BUILD PHASE
pushd source
mkdir build
cd build
cmake \
    -DCMAKE_BUILD_TYPE=Release -DGPL=ON \
    ..
make -j "$(nproc)"
popd

# COPY PHASE
cp -rfv source/build/ecwolf "$diststart/common/dist/"
cp -rfv source/build/ecwolf.pk3 "$diststart/common/dist/"
cp -rfv assets/* "$diststart/common/dist/"
