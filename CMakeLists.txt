cmake_minimum_required(VERSION 3.0)
project(DMTX VERSION 0.7.7 LANGUAGES C)

option(DMTX_SHARED "Build DMTX as shared library" ${BUILD_SHARED_LIBS})
add_library(dmtx SHARED "dmtx.c")

if (COMPILER_NEEDS_FLOAT_STORE)
    target_compile_options(dmtx PRIVATE
        -ffloat-store   # same floating point precision in all optimization levels
    )
endif()
target_compile_features(dmtx PUBLIC cxx_std_17)
if (MSVC)
    set_target_properties(dmtx PROPERTIES WINDOWS_EXPORT_ALL_SYMBOLS ON)
else()
    set_target_properties(dmtx PROPERTIES
                                  VERSION ${PROJECT_VERSION}
                                  SOVERSION ${PROJECT_VERSION_MAJOR})
    target_link_libraries(dmtx PUBLIC -lm)
endif()
# Force position independent code to be able to link it as static lib into a DLL
set_target_properties(dmtx PROPERTIES POSITION_INDEPENDENT_CODE ON)

if (PROJECT_VERSION)
    set_target_properties(dmtx PROPERTIES VERSION ${PROJECT_VERSION})
    set_target_properties(dmtx PROPERTIES SOVERSION ${PROJECT_VERSION_MAJOR})
endif()

set (PUBLIC_HEADERS
	dmtx.h
)

set_target_properties(dmtx PROPERTIES PUBLIC_HEADER "${PUBLIC_HEADERS}")
if (APPLE AND BUILD_APPLE_FRAMEWORK)
    set_target_properties(dmtx PROPERTIES
        FRAMEWORK TRUE
        FRAMEWORK_VERSION "C"
        XCODE_ATTRIBUTE_DEFINES_MODULE YES
        XCODE_ATTRIBUTE_BUILD_LIBRARY_FOR_DISTRIBUTION YES
	XCODE_ATTRIBUTE_MODULEMAP_FILE "module.modulemap"
        XCODE_ATTRIBUTE_CLANG_ENABLE_OBJC_ARC YES
        MACOSX_FRAMEWORK_IDENTIFIER "com.libdmtx.ios"
        CMAKE_XCODE_ATTRIBUTE_ONLY_ACTIVE_ARCH NO
        PUBLIC_HEADER "${PUBLIC_HEADERS}"
        XCODE_ATTRIBUTE_CODE_SIGN_IDENTITY "iPhone Developer"
        XCODE_ATTRIBUTE_ENABLE_BITCODE "NO"
    )
endif()
include (GNUInstallDirs)

install(TARGETS dmtx
        EXPORT dmtxTargets 
        LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
        ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR}
        RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
        FRAMEWORK DESTINATION ${CMAKE_INSTALL_LIBDIR}
        PUBLIC_HEADER DESTINATION ${CMAKE_INSTALL_LIBDIR}
	)

if (MSVC)
    set_target_properties(dmtx PROPERTIES
        COMPILE_PDB_NAME dmtx
        COMPILE_PDB_OUTPUT_DIR ${CMAKE_CURRENT_BINARY_DIR})
    install(FILES ${CMAKE_CURRENT_BINARY_DIR}/dmtx.pdb
            DESTINATION ${CMAKE_INSTALL_LIBDIR}
            CONFIGURATIONS Debug RelWithDebInfo 
            OPTIONAL)
endif()

set (CMAKECONFIG_INSTALL_DIR "${CMAKE_INSTALL_LIBDIR}/cmake/dmtx")

install (
    EXPORT dmtxTargets
    DESTINATION ${CMAKECONFIG_INSTALL_DIR} NAMESPACE dmtx::
)
