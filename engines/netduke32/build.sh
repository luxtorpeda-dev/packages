#!/bin/bash

# CLONE PHASE
git config --global http.sslverify false
export GIT_SSL_NO_VERIFY=1
git clone https://voidpoint.io/StrikerTheHedgefox/eduke32-csrefactor.git source
pushd source
git checkout "$COMMIT_HASH"
popd

# BUILD PHASE
pushd source
make netduke32
popd

# COPY PHASE
cp -rfv "source/netduke32" "$diststart/common/dist/"
cp -rfv "source/eduke32.dat" "$diststart/common/dist/"
cp -rfv assets/* "$diststart/common/dist/"
