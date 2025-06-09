#!/bin/bash

# CLONE PHASE
git clone https://github.com/MadDeCoDeR/Classic-RBDOOM-3-BFG.git source
pushd source
git checkout "$COMMIT_HASH"
git submodule update --init --recursive
popd

git clone https://github.com/MadDeCoDeR/BFA-Assets.git
pushd BFA-Assets
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
cp -rfv ./BFA-Assets/base/* "$diststart/208200/dist/updatedbase"
cp -rfv ./BFA-Assets/base_BFG "$diststart/208200/dist/updatedbase"
mkdir "$diststart/208200/dist/lib"
cp -rfv ./source/buildRetail/_deps/openxr-build/src/loader/libopenxr_loader* "$diststart/208200/dist/lib"

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
