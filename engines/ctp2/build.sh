#!/bin/bash

# CLONE PHASE
git clone https://github.com/ptitSeb/ctp2.git source
pushd source
git checkout 2584d003041a44123994348957b74ee3b11305fc
popd

apt-get install -y byacc

# BUILD PHASE
pushd source
./autogen.sh
CFLAGS="$CFLAGS -w -fuse-ld=gold" CXXFLAGS="$CXXFLAGS -w -fuse-ld=gold" ./configure --enable-silent-rules
make
popd

# COPY PHASE
mkdir -p "$diststart/572050/dist/ctp2_program/ctp/dll/map"
cp -rfv source/ctp2_code/ctp2 "$diststart/572050/dist/ctp2_program/ctp/ctp2"
cp -rfv source/ctp2_data "$diststart/572050/dist/"
cp -rfv source/ctp2_code/mapgen/.libs/*.so "$diststart/572050/dist/ctp2_program/ctp/dll/map"
