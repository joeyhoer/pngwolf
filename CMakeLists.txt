cmake_minimum_required(VERSION 2.7)

set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/lib)
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/lib)
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/bin)

include_directories(zlib 7zip/CPP galib)

add_executable(
    pngwolf
    pngwolf.cxx
    src/galib/ga/GA1DArrayGenome.C
    src/galib/ga/GAAllele.C
    src/galib/ga/GABaseGA.C
    src/galib/ga/gabincvt.C
    src/galib/ga/GAGenome.C
    src/galib/ga/GAIncGA.C
    src/galib/ga/GAParameter.C
    src/galib/ga/GAPopulation.C
    src/galib/ga/garandom.C
    src/galib/ga/gaerror.C
    src/galib/ga/GAScaling.C
    src/galib/ga/GASelector.C
    src/galib/ga/GAStatistics.C
    src/zlib/adler32.c
    src/zlib/compress.c
    src/zlib/crc32.c
    src/zlib/deflate.c
    src/zlib/gzclose.c
    src/zlib/gzlib.c
    src/zlib/gzread.c
    src/zlib/gzwrite.c
    src/zlib/infback.c
    src/zlib/inffast.c
    src/zlib/inflate.c
    src/zlib/inftrees.c
    src/zlib/trees.c
    src/zlib/uncompr.c
    src/zlib/zutil.c
    src/7zip/CPP/7zip/Common/InBuffer.cpp
    src/7zip/CPP/7zip/Common/OutBuffer.cpp
    src/7zip/CPP/7zip/Common/StreamObjects.cpp
    src/7zip/CPP/7zip/Common/StreamUtils.cpp
    src/7zip/CPP/7zip/Compress/BitlDecoder.cpp
    src/7zip/CPP/7zip/Compress/DeflateDecoder.cpp
    src/7zip/CPP/7zip/Compress/DeflateEncoder.cpp
    src/7zip/CPP/7zip/Compress/LzOutWindow.cpp
    src/7zip/CPP/7zip/Compress/ZlibDecoder.cpp
    src/7zip/CPP/7zip/Compress/ZlibEncoder.cpp
    src/7zip/C/Alloc.c
    src/7zip/C/HuffEnc.c
    src/7zip/C/LzFind.c
    src/7zip/C/Sort.c
)
