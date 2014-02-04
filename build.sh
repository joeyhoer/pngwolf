#!/usr/bin/env bash

##
# Ensure proper working directory
##
cd "$( dirname "${BASH_SOURCE[0]}" )"
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"


##
# Make/save directories
##
TMP="tmp"
mkdir -p $TMP

SRC="src"
mkdir -p $SRC

PAT="patches"

##
# Download dependancies
##
if [ ! -f "$TMP/galib.tgz" ]; then
	echo "Downloading GALib"
	curl -q#L "http://lancet.mit.edu/ga/dist/galib247.tgz" > "$TMP/galib.tgz"
else
	echo "GALib source exists... skipping"
fi

if [ ! -f "$TMP/p7zip.tar.bz2" ]; then
	echo "Downloading 7-Zip"
	# This could break as it's using the "latest" version
	curl -q#L "http://sourceforge.net/projects/p7zip/files/latest/download" > "$TMP/p7zip.tar.bz2"
	# Alternatively, specify a specific version
	# `projects/sevenzip/files/7-Zip/9.20/7z920.tar.bz2/download`
else
	echo "7-Zip source exists... skipping"
fi

if [ ! -f "$TMP/zlib.tar.gz" ]; then
	echo "Downloading zlib"
	curl -q#L "http://zlib.net/zlib-1.2.8.tar.gz" > "$TMP/zlib.tar.gz"
else
	echo "zlib source exists... skipping"
fi


##
# Extract source files
##
echo "Extracting GALib"
mkdir -p "$SRC/galib"
tar -xzf "$TMP/galib.tgz"     --strip-components 1  -C "$SRC/galib"

echo "Extracting 7-Zip"
mkdir -p "$SRC/7zip"
tar -xjf "$TMP/p7zip.tar.bz2" --strip-components 1  -C "$SRC/7zip"

echo "Extracting zlib"
mkdir -p "$SRC/zlib"
tar -xzf "$TMP/zlib.tar.gz"   --strip-components 1  -C "$SRC/zlib"


##
# Apply patches
##
echo "Patching GALib"
patch -d "$SRC" -fp 0 < "$PAT/galib247.patch"

echo "Patching 7-Zip"
patch -d "$SRC" -fp 0 < "$PAT/sevenzip9201.patch"
# Patch using bash
# Remove references to Visual Studio precompiled headers
grep -lR '#include "StdAfx.h"' "$SRC/7zip" | xargs sed -i "" -E 's/#include "StdAfx.h"//g'


##
# Make binary
##
echo "Making binary"
cmake -H. -Bbuild #CMakeLists.txt
make -sC build/