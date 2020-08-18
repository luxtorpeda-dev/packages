#!/bin/bash

# CLONE PHASE
git clone https://github.com/OpenRCT2/OpenRCT2.git source
pushd source
git checkout -f 135cc10
git am < ../patches/0001-Disable-Werror.patch
popd

git clone https://github.com/akheron/jansson.git jansson
pushd jansson
git checkout -f e9ebfa7
popd

git clone https://github.com/nih-at/libzip.git libzip
pushd libzip
git checkout -f dcd9a0b
popd

git clone https://github.com/unicode-org/icu.git icu
pushd icu
git checkout -f c8bc56e
popd

git clone https://github.com/glennrp/libpng.git libpng
pushd libpng
git checkout -f c17d164
popd

git clone https://github.com/svaarala/duktape.git duktape
pushd duktape
git checkout -f 6001888
popd

wget https://github.com/OpenRCT2/objects/releases/download/v1.0.16/objects.zip
wget https://github.com/OpenRCT2/title-sequences/releases/download/v0.1.2c/title-sequences.zip

readonly pfx="$PWD/local"
mkdir -p "$pfx"

export PKG_CONFIG_PATH="$PKG_CONFIG_PATH:$pfx/lib/pkgconfig"

# BUILD PHASE
pushd jansson
mkdir build
cd build
cmake \
    -DCMAKE_INSTALL_PREFIX="$pfx" \
    -DJANSSON_BUILD_SHARED_LIBS=ON \
    ..
make -j "$(nproc)"
make install
popd

pushd libpng
mkdir build
cd build
cmake \
    -DCMAKE_INSTALL_PREFIX="$pfx" \
    ..
make -j "$(nproc)"
make install
popd

pushd libzip
mkdir build
cd build
cmake \
    -DCMAKE_INSTALL_PREFIX="$pfx" \
    ..
make -j "$(nproc)"
make install
popd

pushd icu/icu4c/source
./runConfigureICU Linux --prefix="$pfx"
make -j "$(nproc)"
make install
popd

sudo apt-get install -y python-yaml bc
curl -s https://setconf.roboticoverlords.org/setconf-0.7.7.tar.xz | tar JxC /tmp
sudo install -Dm755 /tmp/setconf-0.7.7/setconf.py /usr/bin/setconf
sudo install -Dm644 /tmp/setconf-0.7.7/setconf.1.gz /usr/share/man/man1/setconf.1.gz

pushd "duktape"
make dist -j "$(nproc)"
popd

pushd "duktape/dist"
mv Makefile.sharedlibrary Makefile
sed 's/-Wall -Wextra/$(CFLAGS)/g' -i Makefile
CFLAGS="$CFLAGS -D DUK_USE_FASTINT -w" make -j "$(nproc)"
setconf Makefile INSTALL_PREFIX="$pfx"
make install
popd

pushd source
mkdir build
cd build
cmake \
    -DCMAKE_PREFIX_PATH="$pfx" \
    -DCMAKE_CXX_FLAGS="-Wno-sign-compare -fpermissive" \
    -DDUKTAPE_LIBRARY="$pfx/lib/libduktape.so" \
    -DDUKTAPE_INCLUDE_DIR="$pfx/include" \
    -DICU_ROOT="$pfx" \
    -DJANSSON_LIBRARIES="$pfx/lib/libjansson.so" \
    -DLIBZIP_LIBRARIES="$pfx/lib/libzip.so" \
    -DPNG_LIBRARIES="$pfx/lib/libpng16.so" \
    ..
make -j "$(nproc)"
cp -rfv ../data .
make g2
popd

# COPY PHASE
mkdir -p "$diststart/common/dist/lib"
mkdir -p "$diststart/common/dist/data/object"
cp -rfv "$pfx/lib/"*.so* "$diststart/common/dist/lib"

cp -rfv "source/build/openrct2" "$diststart/common/dist/"
cp -rfv "source/build/openrct2-cli" "$diststart/common/dist/"
cp -rfv "source/build/data/"* "$diststart/common/dist/data"
cp -rfv "source/build/g2.dat" "$diststart/common/dist/data"

cp -rfv "assets/run-openrct2.sh" "$diststart/common/dist"
cp -rfv "assets/setup-rct1.sh" "$diststart/common/dist"
cp -rfv "assets/setup-rct2.sh" "$diststart/common/dist"

unzip objects.zip -d "$diststart/common/dist/data/object"
unzip title-sequences.zip -d "$diststart/common/dist/data/title"
