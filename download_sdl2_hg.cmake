
# This file downloads, configures and build SDL2 from official HG dependencies package.
#
# Output Variables:
# SDL2_INSTALL_DIR			    The install directory
# SDL2_REPOSITORY_PATH  		The reposotory directory

# Require ExternalProject and GIT!
include(ExternalProject)
find_package(Git REQUIRED)

# Posttible Input Vars:
# <None>

# SET OUTPUT VARS
# set(SDL2_INSTALL_DIR ${CMAKE_BINARY_DIR}/external/install)
set(SDL2_INSTALL_DIR ${CMAKE_BINARY_DIR})
set(SDL2_REPOSITORY_PATH ${SDL2_INSTALL_DIR})

set(SDL2_CMAKE_FPIC_FLAG "")
if(NOT WIN32)
    set(SDL2_CMAKE_FPIC_FLAG "-DSDL_STATIC_PIC=ON")
else()
    set(SDL2_NOWASAPI "-DWASAPI=OFF")
endif()

# Remove this workaround when the tarball is symlink-free for better Windows compatibility.
# In the meantime, use the auto-tracking SDL2 Git repo:
if(WIN32)
    set(SDL_SOURCE_PATH_GIT "https://github.com/spurious/SDL-mirror.git")
    message("== SDL2 will be downloaded as unofficial GIT repository")
else()
    set(SDL_SOURCE_PATH_URL "https://hg.libsdl.org/SDL/archive/default.tar.bz2")
    message("== SDL2 will be downloaded from official Mercirual as TAR-BZ2 archive")
endif()

ExternalProject_Add(
    SDL2HG
    PREFIX ${CMAKE_BINARY_DIR}/external/SDL2
    GIT_REPOSITORY ${SDL_SOURCE_PATH_GIT}
    URL ${SDL_SOURCE_PATH_URL}
    CMAKE_ARGS
        "-DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE}"
        "-DCMAKE_INSTALL_PREFIX=${CMAKE_BINARY_DIR}"
        -DSNDIO=OFF
        -DSDL_SHARED=${BUILD_SDL2_SHARED}
        -DSDL_STATIC=${BUILD_SDL2_STATIC}
        -DCMAKE_DEBUG_POSTFIX=${CMAKE_DEBUG_POSTFIX}
        ${SDL2_CMAKE_FPIC_FLAG}
        ${SDL2_NOWASAPI} # WASAPI, No way!
)

# Install built SDL's headers and libraries into actual installation directory
install(
    CODE "file( GLOB builtSdl2Heads \"${CMAKE_BINARY_DIR}/include/SDL2/*.h\" )"
    CODE "file( INSTALL \${builtSdl2Heads} DESTINATION \"${CMAKE_INSTALL_PREFIX}/include/SDL2\" )"
    CODE "file( GLOB builtSdlLibs \"${CMAKE_BINARY_DIR}/lib/*SDL2*\" )"
    CODE "file( INSTALL \${builtSdlLibs} DESTINATION \"${CMAKE_INSTALL_PREFIX}/lib\" )"
    CODE "file( GLOB builtSdlBins \"${CMAKE_BINARY_DIR}/bin/*SDL2*\" )"
    CODE "file( INSTALL \${builtSdlBins} DESTINATION \"${CMAKE_INSTALL_PREFIX}/bin\" )"
)
