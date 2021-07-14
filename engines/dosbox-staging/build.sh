#!/bin/bash

git clone https://github.com/pyenv/pyenv.git ~/.pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"

pyenv install 3.6.0
pyenv local 3.6.0
pip3 install --upgrade pip
pip3 install meson

# CLONE PHASE
git clone https://github.com/dosbox-staging/dosbox-staging.git source
pushd source
git checkout -f 15a57e2
git cherry-pick 34b58ebf9f63da42e04f6cadb9920fb243a9cb26
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
cp -rfv "$pfx/source/build/dosbox" "$diststart/common/dist/"
cp -rfv assets/*.sh "$diststart/common/dist/"
