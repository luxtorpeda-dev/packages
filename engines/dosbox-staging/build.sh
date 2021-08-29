#!/bin/bash

git clone https://github.com/pyenv/pyenv.git ~/.pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"

pyenv install 3.6.2
pyenv local 3.6.2
pip3 install --upgrade pip
pip3 install meson

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
cp -rfv "source/build/dosbox" "$diststart/common/dist/"

cp -rfv assets/*.sh "$diststart/common/dist/"
