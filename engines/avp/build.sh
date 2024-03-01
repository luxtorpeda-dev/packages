#!/bin/bash

# CLONE PHASE
git clone https://github.com/neuromancer/avp.git source
pushd source
git checkout "$COMMIT_HASH"
git am < ../patches/0001-Remove-RenderSmallFontString_Wrapped-call-in-RenderH.patch
git am < ../patches/0001-allow-unlimited-saves.patch
git am < ../patches/0001-Fix-for-gcc-10.patch
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
