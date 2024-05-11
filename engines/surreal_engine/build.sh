#!/bin/bash

# CLONE PHASE
git clone https://github.com/dpjudas/SurrealEngine.git source
pushd source
git checkout "$COMMIT_HASH"
popd

# BUILD PHASE
pushd "source"
mkdir build
cd build
cmake -DCMAKE_BUILD_TYPE=Release ..
make -j "$(nproc)"
popd

# COPY PHASE
cp -rfv source/build/SurrealEngine* "$diststart/common/dist/"
