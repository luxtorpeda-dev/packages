#!/bin/bash

# CLONE PHASE
git clone https://github.com/libsdl-org/SDL_image.git sdl2_image
pushd sdl2_image
git checkout -f a861543
popd

# BUILD PHASE
pushd "sdl2_image"
touch NEWS README AUTHORS ChangeLog
autoreconf --force --install
./configure --disable-static --prefix="$pfx"
make -j "$(nproc)"
make install
popd

cp -rfv "$pfx/lib/"* /usr/lib
cp -rfv "$pfx/include/"* /usr/include
