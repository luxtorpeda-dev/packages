#!/bin/bash

# CLONE PHASE
git clone https://github.com/cortex-command-community/Cortex-Command-Community-Project.git source
pushd source
git checkout -f "${COMMIT_TAG}"
popd

# BUILD PHASE
pushd source
meson setup build
ninja -C build
popd

# COPY PHASE
cp -rvf source/Data "${diststart}/209670/dist/Data"
cp -v source/build/CortexCommand "${diststart}/209670/dist/CortexCommand"
cp -v assets/cccp.sh "${diststart}/209670/dist/cccp.sh"
mkdir -p "${diststart}/209670/dist/lib"
find source/external/lib/linux/x86_64/ -name '*.so*' -exec cp -v "{}" "${diststart}/209670/dist/lib/" \;
