#!/bin/bash
#
# node.sh [base directory] [version]
#
# Retrieves and builds "version". Base directory (i.e., /usr/local) is where
# any installed files will be rooted. Defaults to current directory.
#

VERSION="0.6.8"
BASEDIR=$(pwd)

if [ $# -gt 0 ] ; then
  BASEDIR=$1
fi

if [ $# -gt 1 ] ; then
  VERSION=$2
fi


FILENAME=node-v$VERSION.tar.gz

mkdir -p $BASEDIR/src
pushd $BASEDIR/src

echo "=== DOWNLOADING $FILENAME ==="
curl -O http://nodejs.org/dist/v$VERSION/$FILENAME

echo "=== UNPACKING $FILENAME ==="
tar xvzf $FILENAME

pushd $(basename $FILENAME .tar.gz)

echo "=== CONFIGURING $FILENAME ==="

./configure --prefix=$BASEDIR

if [ $? -eq 0 ] ; then
  echo "=== BUILDING $FILENAME ==="
  make
fi

if [ $? -eq 0 ] ; then
  echo "=== INSTALLING $FILENAME ==="
  make install
fi

if [ $? -eq 0 ] ; then
  echo "=== INSTALLING npm ==="
  curl http://npmjs.org/install.sh | sh
fi


popd

popd



