#!/bin/bash

# CLONE PHASE
git clone https://github.com/dosbox-staging/dosbox-staging.git source
pushd source
git checkout -f 4ee43d5
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
cp -rfv "source/build/dosbox" "$diststart/common/dist/"
cp -rfv "source/build/resources" "$diststart/common/dist/"
cp -rfv assets/*.sh "$diststart/common/dist/"
