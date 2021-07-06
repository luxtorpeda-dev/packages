#!/bin/bash

git clone https://github.com/pyenv/pyenv.git ~/.pyenv
echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.profile
echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.profile
echo 'eval "$(pyenv init --path)"' >> ~/.profile

pyenv install 3.6.0
pyenv local 3.6.0
pip3 install meson

# CLONE PHASE
git clone https://github.com/dosbox-staging/dosbox-staging.git source
pushd source
git checkout -f 15a57e2
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
