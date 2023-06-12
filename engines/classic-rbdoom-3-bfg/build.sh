#!/bin/bash

# CLONE PHASE
git clone https://github.com/MadDeCoDeR/Classic-RBDOOM-3-BFG.git source
pushd source
git checkout 2f1c697
git submodule update --init --recursive
popd

pushd "source/neo"
mkdir build
cd build
cmake \
    -DCMAKE_BUILD_TYPE=RelWithDebInfo \
    -DSDL2=ON \
    -DCMAKE_PREFIX_PATH="$pfx" \
    --preset=linux-retail \
    ..
cd ../../buildRetail
make -j "$(nproc)"
popd

# COPY PHASE
cp "source/buildRetail/DoomBFA" "$diststart/208200/dist/DoomBFA"

cp -rfv ./assets/* "$diststart/208200/dist/"
cp -rfv ./source/base "$diststart/208200/dist/updatedbase"

mkdir -p licenses
licensepath="$PWD/licenses"
pushd ./source/buildRetail/vcpkg_installed/x64-linux/share
for d in */ ; do
    directory=${d::-1}
    echo "$directory"
    if [ -f "$directory/copyright" ]; then
        cp -rfv "$d/copyright" "$licensepath/$directory.copyright"
    fi
done
popd
