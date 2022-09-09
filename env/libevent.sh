#!/bin/sh

# exit on error
set -e

URL=$HOME/local/package/libevent-2.1.8-stable.tar.gz
TMP=$HOME/local/package/tmp_libevent
PREFIX=$HOME/local/stow/libevent

# create our directories
mkdir -p $TMP $PREFIX
cd $TMP

# download source files for libevent, libevent, and ncurses
cp -vr $URL libevent.tar.gz

# extract files, configure, and compile
mkdir -p $TMP/build
tar xvzf libevent.tar.gz -C $TMP/build --strip-components=1
cd build
./configure --prefix=$PREFIX --disable-shared
make
make install

cd $PREFIX/../
stow libevent

# cleanup
rm -rf $TMP

echo "libevent is now available. You can optionally add $HOME/local/bin to your PATH."
