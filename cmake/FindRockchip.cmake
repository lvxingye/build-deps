# - Try to find Rockchip MPP and RGA
#
# Once done this will define:
#
#  Rockchip_FOUND
#  Rockchip_INCLUDE_DIRS
#  Rockchip_LIBRARIES
#  Rockchip::Rockchip (imported target)

find_package(PkgConfig REQUIRED)

# ------------------------------------------------------------
# Find rkmpp
# ------------------------------------------------------------
pkg_check_modules(RKMPP REQUIRED rockchip_mpp)

# ------------------------------------------------------------
# Find rga
# ------------------------------------------------------------
pkg_check_modules(RGA REQUIRED librga)

# ------------------------------------------------------------
# Aggregate include dirs and libs
# ------------------------------------------------------------
set(Rockchip_INCLUDE_DIRS
    ${RKMPP_INCLUDE_DIRS}
    ${RGA_INCLUDE_DIRS}
)

set(Rockchip_LIBRARIES
    ${RKMPP_LIBRARIES}
    ${RGA_LIBRARIES}
)

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(Rockchip
    REQUIRED_VARS Rockchip_INCLUDE_DIRS Rockchip_LIBRARIES
)

# ------------------------------------------------------------
# Create imported target
# ------------------------------------------------------------
if(Rockchip_FOUND AND NOT TARGET Rockchip::Rockchip)

    add_library(Rockchip::Rockchip INTERFACE IMPORTED)

    set_target_properties(Rockchip::Rockchip PROPERTIES
        INTERFACE_INCLUDE_DIRECTORIES "${Rockchip_INCLUDE_DIRS}"
        INTERFACE_LINK_LIBRARIES "${Rockchip_LIBRARIES}"
    )

endif()
