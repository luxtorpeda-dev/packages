#!/bin/bash

sudo apt-get update
sudo apt-get -y install python3 python3-pip
sudo pip3 install meson

# CLONE PHASE
git clone https://github.com/dosbox-staging/dosbox-staging.git source
pushd source
git checkout -f 15a57e2
popd

git clone https://github.com/xiph/opusfile.git opusfile
pushd opusfile
git checkout -f a55c164
popd

readonly pfx="$PWD/local"
mkdir -p "$pfx"
export PKG_CONFIG_PATH="$PKG_CONFIG_PATH:$pfx/lib64/pkgconfig"

# BUILD PHASE
pushd "opusfile"
./autogen.sh
./configure CFLAGS="-O3" CXXFLAGS="-O3" --prefix="$pfx"
make -j "$(nproc)"
make install
popd

pushd "source"
meson setup -Dbuildtype=release \
-Dc_args=-Ofast \
-Dcpp_args=-Ofast \
-Db_asneeded=true -Dstrip=true \
-Ddefault_library=static \
-Dfluidsynth:enable-floats=true \
-Dfluidsynth:try-static-deps=true build
popd

# COPY PHASE
mkdir -p "$diststart/common/dist/lib"
cp -rfv "$pfx/bin/dosbox" "$diststart/common/dist/"
cp -rfv "$pfx/lib64/"*.so* "$diststart/common/dist/lib"
cp -rfv assets/*.sh "$diststart/common/dist/"
