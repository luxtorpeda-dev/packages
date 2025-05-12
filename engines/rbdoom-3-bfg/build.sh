#!/bin/bash

wget https://github.com/ispc/ispc/releases/download/v1.26.0/ispc-v1.26.0-linux.tar.gz
tar xvf ispc-v1.26.0-linux

export PATH="$PATH:$PWD/ispc-v1.26.0-linux/bin"

# CLONE PHASE
git clone https://github.com/RobertBeckebans/RBDOOM-3-BFG.git source
pushd source
git checkout "$COMMIT_TAG"
git submodule update --init --recursive
popd

pushd "source"
mkdir build
cd build
cmake \
    -G "Eclipse CDT4 - Unix Makefiles" \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_PREFIX_PATH="$pfx" \
    -DFFMPEG=OFF \
    -DBINKDEC=ON \
    -DDXC_CUSTOM_PATH="$VCPKG_INSTALLED_PATH/tools/directx-dxc" \
    ../neo
make -j "$(nproc)"
popd

# COPY PHASE
cp "source/build/RBDoom3BFG" "$diststart/208200/dist/RBDoom3BFG"
cp -rfv "source/base" "$diststart/208200/dist/"
cp -rfv ./assets/run-rbdoom-3-bfg.sh "$diststart/208200/dist/"
