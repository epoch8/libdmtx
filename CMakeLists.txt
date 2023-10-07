cmake_minimum_required(VERSION 3.0)
project(DMTX VERSION 0.7.7 LANGUAGES C)

# Group source files
set(DMTX_SOURCES "dmtx.c")
set(DMTX_HEADERS "dmtx.h" "dmtxstatic.h")

add_library(dmtx SHARED ${DMTX_SOURCES} ${DMTX_HEADERS})

# Compiler specific settings
set_target_properties(dmtx PROPERTIES
                                VERSION ${PROJECT_VERSION}
                                SOVERSION ${PROJECT_VERSION_MAJOR})

target_link_libraries(dmtx PUBLIC -lm)

# Force position independent code
set_target_properties(dmtx PROPERTIES POSITION_INDEPENDENT_CODE ON)

target_compile_options(dmtx PRIVATE -fsigned-char)

set_target_properties(dmtx PROPERTIES PUBLIC_HEADER "${CMAKE_CURRENT_SOURCE_DIR}/dmtx.h")

install(TARGETS dmtx LIBRARY ARCHIVE RUNTIME PUBLIC_HEADER)

# Add tests if DMTX is the main project
if(CMAKE_PROJECT_NAME STREQUAL PROJECT_NAME)
    include(CTest)
    if(BUILD_TESTING)
      add_subdirectory("test")
    endif()
endif()
