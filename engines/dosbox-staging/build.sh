#!/bin/bash

wget https://bootstrap.pypa.io/get-pip.py

python3 get-pip.py
pip3 install meson --upgrade

# CLONE PHASE
git clone https://github.com/dosbox-staging/dosbox-staging.git source
pushd source
git checkout -f 30d8752
popd

# BUILD PHASE
pushd "source"
meson setup -Dbuildtype=release \
    -Dc_args=-Ofast \
    -Dcpp_args=-Ofast \
    -Db_asneeded=true -Dstrip=true \
    -Ddefault_library=static \
    -Dfluidsynth:enable-floats=true \
    -Dfluidsynth:try-static-deps=true \
    build
ninja -C build
popd

# COPY PHASE
mkdir -p "$diststart/common/dist/lib"

cp -rfv "source/build/subprojects/fluidsynth-2.2.0/libfluidsynth.so" "$diststart/common/dist/lib"
cp -rfv "source/build/subprojects/munt-libmt32emu_2_5_0/libmt32emu.so" "$diststart/common/dist/lib"

cp -rfv "source/build/dosbox" "$diststart/common/dist/"

cp -rfv assets/*.sh "$diststart/common/dist/"
