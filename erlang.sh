#!/bin/bash
#
# erlang.sh [base directory] [version]
#
# Retrieves and builds "version". Base directory (i.e., /usr/local) is where
# any installed files will be rooted. Defaults to current directory.
#

VERSION="R15B"
BASEDIR=$(pwd)

if [ $# -gt 0 ] ; then
  BASEDIR=$1
fi

if [ $# -gt 1 ] ; then
  VERSION=$2
fi

FILENAME=otp_src_$VERSION.tar.gz

mkdir -p $BASEDIR/src
pushd $BASEDIR/src

curl -O http://www.erlang.org/download/$FILENAME

tar xvzf $FILENAME

pushd $(basename $FILENAME .tar.gz)

./configure --prefix=$BASEDIR --enable-threads --enable-halfword-emulator --enable-smp-support --enable-kernel-poll --enable-sctp --enable-hipe --enable-native-libs --enable-shared-zlib

make && make install

popd

popd

