#!/bin/bash

# CLONE PHASE
git clone https://voidpoint.io/terminx/eduke32.git source
pushd source
git checkout b7d4ae3a561e0e6f26d999ce5dde7328c68725c0
popd

# BUILD PHASE
pushd source
make voidsw
popd

# COPY PHASE
