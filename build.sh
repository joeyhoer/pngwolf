#!/usr/bin/env bash

cd "$( dirname "${BASH_SOURCE[0]}" )"
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Download dependancies
SRC="src"
mkdir -p $SRC

echo "Downloading GALib"
curl -q#L "http://lancet.mit.edu/ga/dist/galib247.tgz" > "$SRC/galib.tgz"

echo "Downloading 7-Zip"
# This could break as it's using the "latest" version
curl -q#L "http://sourceforge.net/projects/p7zip/files/latest/download" > "$SRC/p7zip.tar.bz2"
# Alternatively, specify a specific version
# curl -#L "http://sourceforge.net/projects/sevenzip/files/7-Zip/9.20/7z920.tar.bz2/download" > "$SRC/p7zip.tar.bz2"

echo "Downloading zlib"
curl -q#L "http://zlib.net/zlib-1.2.8.tar.xz" > "$SRC/zlib.tar.xz"


# Extract source files
echo "Extracting GALib"
mkdir -p "galib"
tar xf "$SRC/galib.tgz"     --strip-components 1  -C "galib"

echo "Extracting 7-Zip"
mkdir -p "7zip"
tar xf "$SRC/p7zip.tar.bz2" --strip-components 1  -C "7zip"

echo "Extracting zlib"
mkdir -p "zlib"
tar xf "$SRC/zlib.tar.xz"   --strip-components 1  -C "zlib"

# Apply patches
PAT="patches"

echo "Patching GALib"
patch -fp 0 < "$PAT/galib247.patch"

echo "Patching 7-Zip"
patch -fp 0 < "$PAT/sevenzip9201.patch"
# Remove references to Visual Studio precompiled headers
grep -lR '#include "StdAfx.h"' ./7zip/ | xargs sed -i "" -E 's/#include "StdAfx.h"//g'


# Make
cmake CMakeLists.txt
make