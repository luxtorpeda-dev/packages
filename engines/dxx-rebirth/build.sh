#!/bin/bash

# CLONE PHASE
git clone https://github.com/dxx-rebirth/dxx-rebirth.git source
pushd source
git checkout -f "$COMMIT_HASH"
popd

# BUILD PHASE
curl https://pyenv.run | bash

export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init - bash)"

pyenv install 3.11.6
pyenv global 3.11.6

python -m ensurepip --default-pip
pip install scons
scons --version

pushd source
scons -j`nproc` sdl2=1
popd

# COPY PHASE
cp -rfv source/build/d1x-rebirth/d1x-rebirth "$diststart/273570/dist/"
cp -rfv source/build/d2x-rebirth/d2x-rebirth "$diststart/273580/dist/"

cp -rfv assets/run-d1x.sh "$diststart/273570/dist/"
cp -rfv assets/run-d2x.sh "$diststart/273580/dist/"
