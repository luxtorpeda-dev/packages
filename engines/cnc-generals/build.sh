#!/bin/bash

# CLONE PHASE
git clone https://github.com/Fighter19/CnC_Generals_Zero_Hour.git source
pushd source
git checkout "$COMMIT_HASH"
popd

export VCPKG_SRC_PATH="$PWD/vcpkg"
export VCPKG_ROOT="$PWD/vcpkg"

# clone repo and setup vcpkg
git clone https://github.com/Microsoft/vcpkg.git vcpkg
./vcpkg/bootstrap-vcpkg.sh

# BUILD PHASE
pushd source
mkdir build
cd build
cmake \
    --preset deploy \
    -DSAGE_USE_SDL3=ON \
    -DSAGE_USE_GLM=ON \
    -DSAGE_USE_OPENAL=ON \
    ..
popd

pushd source
cmake --build --preset deploy --target RTS
popd

# COPY PHASE
ls -l source/build/deploy/GeneralsMD
cp -rfv source/build/deploy/GeneralsMD/Code/RTS "$diststart/common/dist/"
cp -rfv assets/* "$diststart/common/dist/"

mkdir -p licenses
licensepath="$PWD/licenses"
pushd ./source/build/deploy/vcpkg_installed/x64-linux/share
for d in */ ; do
    directory=${d::-1}
    echo "$directory"
    if [ -f "$directory/copyright" ]; then
        cp -rfv "$d/copyright" "$licensepath/$directory.copyright"
    fi
done
popd
