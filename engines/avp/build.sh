#!/bin/bash

# CLONE PHASE
git clone https://github.com/atsb/NakedAVP source
pushd source
git checkout "$COMMIT_HASH"
popd

# BUILD PHASE
pushd "source"
mkdir -p build
cd build
cmake \
    -DCMAKE_BUILD_TYPE=MinSizeRel \
    -DOpenGL_GL_PREFERENCE="GLVND" \
    -DSDL_TYPE="SDL" \
    ..
make -j "$(nproc)"
popd

# COPY PHASE
cp -rfv "source/build/avp" "$diststart/3730/dist/avp"
cp -rfv "assets/run-avp.sh" "$diststart/3730/dist/"
