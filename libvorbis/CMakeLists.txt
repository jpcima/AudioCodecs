cmake_minimum_required (VERSION 2.8.11)
project (libVorbis)

add_definitions(
    -DHAVE_CONFIG_H
)

add_library(vorbis STATIC
    lib/analysis.c
    lib/bitrate.c
    lib/block.c
    lib/codebook.c
    lib/envelope.c
    lib/floor0.c
    lib/floor1.c
    lib/info.c
    lib/lookup.c
    lib/lpc.c
    lib/lsp.c
    lib/mapping0.c
    lib/mdct.c
    lib/psy.c
    lib/registry.c
    lib/res0.c
    lib/sharedbook.c
    lib/smallft.c
    lib/synthesis.c
    lib/window.c
)

add_library(vorbisfile STATIC
    lib/vorbisfile.c
)

add_library(vorbisenc STATIC
    lib/vorbisenc.c
)

include_directories(${CMAKE_CURRENT_SOURCE_DIR}/include)
include_directories(${CMAKE_CURRENT_SOURCE_DIR}/lib)
include_directories(${CMAKE_CURRENT_SOURCE_DIR}/../libogg/include)

target_include_directories(vorbis PUBLIC ${CMAKE_CURRENT_SOURCE_DIR}/include)
target_include_directories(vorbisfile PUBLIC ${CMAKE_CURRENT_SOURCE_DIR}/include)
target_include_directories(vorbisfile PUBLIC ${CMAKE_CURRENT_SOURCE_DIR}/include)
