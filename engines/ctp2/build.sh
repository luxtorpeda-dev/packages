#!/bin/bash

# CLONE PHASE
git clone https://github.com/atsb/civctp2.git source
pushd source
git checkout 4b301b0
sed -i 's/2.71/2.69/g' configure.ac
popd

# BUILD PHASE
pushd source
cp -rfv "EULA - Source Code for CTP2.rtf" "EULA.rtf"
cp -rfv "Activision CTP2 Source Code_Readme.txt" "Activision_CTP2_Source_Code_Readme.txt"
cp -rfv "Apolyton CTP2 Source Code_Readme.txt" "Apolyton_CTP2_Source_Code_Readme.txt"

./autogen.sh
CFLAGS="$CFLAGS -O3 -fuse-ld=gold" CXXFLAGS="$CXXFLAGS -fpermissive -O3 -fuse-ld=gold" ./configure --enable-silent-rules --prefix="$pfx"
make
popd

# COPY PHASE
mkdir -p "$diststart/572050/dist/ctp2_program/ctp/dll/map"
cp -rfv source/ctp2_code/ctp2 "$diststart/572050/dist/ctp2_program/ctp/ctp2"
cp -rfv source/ctp2_data "$diststart/572050/dist/"
cp -rfv source/ctp2_code/mapgen/.libs/*.so "$diststart/572050/dist/ctp2_program/ctp/dll/map"
cp -rfv assets/run-ctp2.sh "$diststart/572050/dist/run-ctp2.sh"
