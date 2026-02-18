# - Try to find libdrm
#
# Once done this will define:
#
#  LibDRM_FOUND
#  LibDRM_INCLUDE_DIRS
#  LibDRM_LIBRARIES
#  LibDRM::LibDRM (imported target)

find_package(PkgConfig REQUIRED)

# ------------------------------------------
# pkg-config lookup
# ------------------------------------------
pkg_check_modules(PC_LIBDRM libdrm)

# ------------------------------------------
# Fallback manual search (important for cross-compile)
# ------------------------------------------
find_path(LibDRM_INCLUDE_DIR
    NAMES xf86drm.h
    HINTS ${PC_LIBDRM_INCLUDE_DIRS}
)

find_library(LibDRM_LIBRARY
    NAMES drm
    HINTS ${PC_LIBDRM_LIBRARY_DIRS}
)

# ------------------------------------------
# Handle result
# ------------------------------------------
include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(LibDRM
    REQUIRED_VARS LibDRM_INCLUDE_DIR LibDRM_LIBRARY
)

if(LibDRM_FOUND)

    set(LibDRM_INCLUDE_DIRS ${LibDRM_INCLUDE_DIR})
    set(LibDRM_LIBRARIES ${LibDRM_LIBRARY})

    if(NOT TARGET LibDRM::LibDRM)
        add_library(LibDRM::LibDRM UNKNOWN IMPORTED)

        set_target_properties(LibDRM::LibDRM PROPERTIES
            IMPORTED_LOCATION "${LibDRM_LIBRARY}"
            INTERFACE_INCLUDE_DIRECTORIES "${LibDRM_INCLUDE_DIR}"
        )
    endif()

endif()
