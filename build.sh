#!/usr/bin/env bash

cd "$( dirname "${BASH_SOURCE[0]}" )"
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Download dependancies
SRC="src"
mkdir -p $SRC

echo "Downloading GALib"
curl -#L "http://lancet.mit.edu/ga/dist/galib247.tgz" > "$SRC/galib.tgz"

echo "Downloading 7-Zip"
# I would rather use the 'latest' version, but it needs to be patched
# http://sourceforge.net/projects/p7zip/files/latest/download
curl -#L "http://sourceforge.net/projects/sevenzip/files/7-Zip/9.20/7z920.tar.bz2/download" > "$SRC/p7zip.tar.bz2"

echo "Downloading zlib"
curl -#L "http://zlib.net/zlib-1.2.8.tar.xz" > "$SRC/zlib.tar.xz"


# Extract source files
echo "Extracting GALib"
mkdir -p "galib"
tar xf "$SRC/galib.tgz"     --strip-components 1  -C "galib"

echo "Extracting 7-Zip"
mkdir -p "7zip"
tar xf "$SRC/p7zip.tar.bz2" -C "7zip"

echo "Extracting zlib"
mkdir -p "zlib"
tar xf "$SRC/zlib.tar.xz"   --strip-components 1  -C "zlib"

# Apply patches
PAT="patches"

echo "Patching GALib"
patch -p 0 < "$PAT/galib247.patch"

echo "Patching 7-Zip"
patch -p 0 < "$PAT/sevenzip920.patch"

# Make
cmake CMakeLists.txt
make