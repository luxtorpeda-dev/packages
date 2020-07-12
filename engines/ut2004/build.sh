#!/bin/bash

# CLONE PHASE
git clone https://github.com/tim241/sdlcl sdlcl
pushd sdlcl
git checkout -f 2d3cc735
popd

git clone https://github.com/kcat/openal-soft.git openal
pushd openal
git checkout -f f5e0eef
popd

wget https://gcc.gnu.org/pub/gcc/releases/gcc-3.3.6/gcc-core-3.3.6.tar.bz2
wget https://gcc.gnu.org/pub/gcc/releases/gcc-3.3.6/gcc-g++-3.3.6.tar.bz2
tar xvf gcc-core-3.3.6.tar.bz2
tar xvf gcc-g++-3.3.6.tar.bz2

readonly pfx="$PWD/local"
mkdir -p "$pfx/lib"

# BUILD PHASE
pushd "sdlcl"
make -j "$(nproc)"
popd

pushd "openal"
cd build
cmake \
    -DCMAKE_BUILD_TYPE=MinSizeRel \
    ..
make -j "$(nproc)"
popd

# gcc build based on https://aur.archlinux.org/packages/lib32-libstdc%2B%2B5/

pushd gcc-3.3.6
sed -e "s#O_CREAT#O_CREAT, 0666#" -i 'gcc/collect2.c'
sed -e 's@\./fixinc\.sh@-c true@' \
    -e '# Clean up some warnings that arent our business' \
    -e 's:-Wstrict-prototypes::g' \
    -e 's:-Wtraditional::g' \
    -e 's:-pedantic::g' \
    -e 's:-Wall::g' \
    -i 'gcc/Makefile.in'
sed -e 's:-Wall -Wtraditional -pedantic::g' -i 'libiberty/configure'
popd

mkdir -p gcc-build
pushd "gcc-build"
export CFLAGS='-O2 -pipe'
export CPPFLAGS='-O2 -pipe'
export CXXFLAGS='-O2 -pipe'
../gcc-3.3.6/configure \
      --enable-__cxa_atexit \
      --enable-languages='c++' \
      --enable-shared \
      --disable-multiarch \
      --disable-multilib \
      --enable-threads='posix' \
      --libdir="$pfx/lib" \
      --prefix="$pfx"
      
# unrelated build step fails, but the library gets built all the same
if nice make all-target-libstdc++-v3 BOOT_CFLAGS="${CFLAGS}" STAGE1_CFLAGS="-O" -j "$(nproc)"
then
    echo "Compile finished..."
else
    echo "Compile stopped..."
fi
popd

# COPY PHASE
cp -rfv "assets/run-ut2004.sh" "$diststart/13230/dist/"
cp -rfv "sdlcl/libSDL-1.2.so.0" "$diststart/13230/dist/"
cp -rfv "openal/build/libopenal.so.1.20.1" "$diststart/13230/dist/openal.so"
cp -rfv "gcc-build/x86_64-unknown-linux-gnu/libstdc++-v3/src/.libs/libstdc++.so.5.0.7" "$diststart/13230/dist/libstdc++.so.5"
