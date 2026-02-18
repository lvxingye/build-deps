# - Try to find libv4l2
#
# Once done this will define:
#
#  LibV4L_FOUND
#  LibV4L_INCLUDE_DIRS
#  LibV4L_LIBRARIES
#  LibV4L::LibV4L (imported target)

find_package(PkgConfig REQUIRED)

# ------------------------------------------
# pkg-config lookup
# ------------------------------------------
pkg_check_modules(PC_LIBV4L libv4l2)

# ------------------------------------------
# Manual fallback
# ------------------------------------------
find_path(LibV4L_INCLUDE_DIR
    NAMES libv4l2.h
    HINTS ${PC_LIBV4L_INCLUDE_DIRS}
)

find_library(LibV4L_LIBRARY
    NAMES v4l2
    HINTS ${PC_LIBV4L_LIBRARY_DIRS}
)

# ------------------------------------------
# Handle result
# ------------------------------------------
include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(LibV4L
    REQUIRED_VARS LibV4L_INCLUDE_DIR LibV4L_LIBRARY
)

if(LibV4L_FOUND)

    set(LibV4L_INCLUDE_DIRS ${LibV4L_INCLUDE_DIR})
    set(LibV4L_LIBRARIES ${LibV4L_LIBRARY})

    if(NOT TARGET LibV4L::LibV4L)
        add_library(LibV4L::LibV4L UNKNOWN IMPORTED)

        set_target_properties(LibV4L::LibV4L PROPERTIES
            IMPORTED_LOCATION "${LibV4L_LIBRARY}"
            INTERFACE_INCLUDE_DIRECTORIES "${LibV4L_INCLUDE_DIR}"
        )
    endif()

endif()
