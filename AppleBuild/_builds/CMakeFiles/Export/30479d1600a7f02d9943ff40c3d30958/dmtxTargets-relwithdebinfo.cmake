#----------------------------------------------------------------
# Generated CMake target import file for configuration "RelWithDebInfo".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "dmtx::dmtx" for configuration "RelWithDebInfo"
set_property(TARGET dmtx::dmtx APPEND PROPERTY IMPORTED_CONFIGURATIONS RELWITHDEBINFO)
set_target_properties(dmtx::dmtx PROPERTIES
  IMPORTED_LOCATION_RELWITHDEBINFO "${_IMPORT_PREFIX}/lib/dmtx.framework/dmtx"
  IMPORTED_SONAME_RELWITHDEBINFO "@rpath/dmtx.framework/dmtx"
  )

list(APPEND _cmake_import_check_targets dmtx::dmtx )
list(APPEND _cmake_import_check_files_for_dmtx::dmtx "${_IMPORT_PREFIX}/lib/dmtx.framework/dmtx" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
