#!/bin/bash

# CLONE PHASE
git clone https://github.com/glKarin/com.n0n3m4.diii4a.git source
pushd source
git checkout "$COMMIT_HASH"
git submodule update --init --recursive
popd

# BUILD PHASE
pushd source
chmod +x cmake_linux_build_doom3_quak4_prey.sh
./cmake_linux_build_doom3_quak4_prey.sh
popd

# COPY PHASE
cp -rfv source/build/Q3E/src/main/jni/doom3/neo/Quake4 "$diststart/common/dist/"
cp -rfv source/build/Q3E/src/main/jni/doom3/neo/Prey "$diststart/common/dist/"
cp -rfv source/build/Q3E/src/main/jni/doom3/neo/libgame.so "$diststart/common/dist/"
cp -rfv source/build/Q3E/src/main/jni/doom3/neo/libpreygame.so "$diststart/common/dist/"
cp -rfv source/build/Q3E/src/main/jni/doom3/neo/libq4game.so "$diststart/common/dist/"

cp -rfv assets/* "$diststart/common/dist/"
