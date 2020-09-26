#!/bin/bash

set -x
set -e

readonly pfx="$PWD/local"
mkdir -p "$pfx"

# build boost
#
pushd "boost"
./bootstrap.sh
./b2 headers
./b2 \
	--with-program_options \
	--with-filesystem \
	--with-system \
	--with-iostreams \
	--with-date_time \
./b2 install --prefix="$pfx"
popd
