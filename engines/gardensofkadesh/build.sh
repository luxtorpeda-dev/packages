#!/bin/bash

# CLONE PHASE
git clone https://github.com/GardensOfKadesh/Homeworld.git source
pushd source
git checkout "$COMMIT_TAG"
popd

# BUILD PHASE
pushd "source"
meson setup build
meson compile -C build
popd

pushd "source"
cp -rfv build/src/ThirdParty/CRC/libhw_crc.a src/ThirdParty/CRC/libhw_CRC.a
cp -rfv build/src/ThirdParty/LZSS/libhw_lzss.a src/ThirdParty/LZSS/libhw_LZSS.a

cd tools/biggie
./biggie-Linux-compile.sh
cd ../../HomeworldSDL_big
./convert_directory_to_big_file
popd

# COPY PHASE
cp -rfv "source/build/homeworld" "$diststart/244160/dist/"
cp -rfv "source/HomeworldSDL.big" "$diststart/244160/dist/"
cp -rfv assets/* "$diststart/244160/dist/"
