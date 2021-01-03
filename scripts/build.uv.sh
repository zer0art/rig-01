#!/bin/bash -e
UV_VERSION="1.40.0"
mkdir -p deps
mkdir -p deps/include
mkdir -p deps/lib
mkdir -p build && cd build
if [ ! -f v${UV_VERSION}.tar.gz ] ; then
wget http://github.com/libuv/libuv/archive/v${UV_VERSION}.tar.gz -O v${UV_VERSION}.tar.gz
fi
tar -xzf v${UV_VERSION}.tar.gz
cd libuv-${UV_VERSION}
sh autogen.sh
./configure --disable-shared
make -j$(nproc || sysctl -n hw.ncpu || sysctl -n hw.logicalcpu)
cp -fr include ../../deps
cp .libs/libuv.a ../../deps/lib
cd ..
