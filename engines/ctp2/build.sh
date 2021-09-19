#!/bin/bash

# CLONE PHASE
git clone https://github.com/civctp2/civctp2.git source
pushd source
git checkout ae8b555
popd

# BUILD PHASE
pushd source
cp -rfv "EULA - Source Code for CTP2.rtf" "EULA.rtf"
cp -rfv "Activision CTP2 Source Code_Readme.txt" "Activision_CTP2_Source_Code_Readme.txt"
cp -rfv "Apolyton CTP2 Source Code_Readme.txt" "Apolyton_CTP2_Source_Code_Readme.txt"

./autogen.sh
CFLAGS="$CFLAGS -O3" CXXFLAGS="$CXXFLAGS -fpermissive -O3" ./configure --enable-silent-rules
make
popd

# COPY PHASE
mkdir -p "$diststart/572050/dist/ctp2_program/ctp/dll/map"

cp -rfv source/ctp2_code/ctp2 "$diststart/572050/dist/ctp2_program/ctp/ctp2"
cp -rfv source/ctp2_data "$diststart/572050/dist/"
cp -rfv source/ctp2_code/mapgen/.libs/*.so "$diststart/572050/dist/ctp2_program/ctp/dll/map"
cp -rfv assets/run-ctp2.sh "$diststart/572050/dist/run-ctp2.sh"
