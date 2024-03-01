#!/bin/bash

# CLONE PHASE
git config --global http.sslverify false
export GIT_SSL_NO_VERIFY=1
git clone https://voidpoint.io/terminx/eduke32.git source
pushd source
git checkout "$COMMIT_HASH"
popd

# BUILD PHASE
pushd source
make voidsw
popd

# COPY PHASE
cp -rfv "source/voidsw" "$diststart/common/dist/"
cp -rfv assets/* "$diststart/common/dist/"
