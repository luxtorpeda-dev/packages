#!/bin/bash

# CLONE PHASE
git clone https://github.com/glKarin/com.n0n3m4.diii4a.git source
pushd source
git checkout "$COMMIT_HASH"
git submodule update --init --recursive
popd

# BUILD PHASE
pushd source
cd Q3E/src/main/jni/doom3/neo
cmake -B build -DCMAKE_SHARED_LINKER_FLAGS=-m64 -DCMAKE_BUILD_TYPE=Release CMakeLists.txt
cmake --build build --config Release
popd


# COPY PHASE
cp -rfv source/Q3E/src/main/jni/doom3/neo/build/lib*.so "$diststart/common/dist/"
cp -rfv source/Q3E/src/main/jni/doom3/neo/build/Quake4 "$diststart/common/dist/"
cp -rfv source/Q3E/src/main/jni/doom3/neo/build/Prey "$diststart/common/dist/"

cp -rfv assets/* "$diststart/common/dist/"
