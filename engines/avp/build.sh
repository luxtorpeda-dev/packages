#!/bin/bash

# CLONE PHASE
git clone https://github.com/neuromancer/avp.git source
pushd source
git checkout 2d57747
git am < ../0001-2560x1080.patch
popd

# BUILD PHASE
cp -rfv "$pfx/include/"* /usr/include/

pushd "source"
mkdir -p build
cd build
cmake \
    -DCMAKE_PREFIX_PATH="$pfx" \
    -DCMAKE_BUILD_TYPE=MinSizeRel \
    -DOpenGL_GL_PREFERENCE="GLVND" \
    -DSDL_TYPE="SDL" \
    ..
make -j "$(nproc)"
popd

# COPY PHASE
cp -rfv "source/build/avp" "$diststart/3730/dist/avp"
cp -rfv "assets/run-avp.sh" "$diststart/3730/dist/"
