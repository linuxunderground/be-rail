cmake_minimum_required(VERSION 3.1.0)

project(be-rail)

include(GNUInstallDirs)

set(STR_VERSION "0.0.1")

set(EXE_NAME be-rail)

set(BE_RAIL_DB
    db/be-rail-fr.sqlite
    db/be-rail-nl.sqlite
    db/be-rail.sqlite
)

if(NOT CMAKE_BUILD_TYPE)
    set(CMAKE_BUILD_TYPE Release)
endif()

# make package_source target
set(CPACK_PACKAGE_NAME "be-rail")
set(CPACK_PACKAGE_VERSION "${STR_VERSION}")
set(CPACK_SOURCE_GENERATOR "TXZ;ZIP")
set(CPACK_SOURCE_PACKAGE_FILE_NAME "${CPACK_PACKAGE_NAME}-${CPACK_PACKAGE_VERSION}")
set(CPACK_SOURCE_IGNORE_FILES "/build/;/CMakeFiles/;/_CPack_Packages/;/\\\\.git/;cmake$;Makefile;\\\\.zip$;tar\\\\.xz$;tar\\\\.bz2$;CMakeCache.txt")
include(CPack)

# simulate autotools' "make dist"
add_custom_target(dist COMMAND ${CMAKE_MAKE_PROGRAM} package_source)


set(DATADIR "${CMAKE_INSTALL_FULL_DATADIR}/be-rail")
add_definitions(-DDATADIR=\"${DATADIR}\")

add_definitions(-DSTR_VERSION=\"${STR_VERSION}\")


add_subdirectory(src)

install(FILES be-rail.desktop DESTINATION "${CMAKE_INSTALL_DATADIR}/applications")
install(FILES be-rail.png DESTINATION "${CMAKE_INSTALL_DATADIR}/pixmaps")
install(FILES ${BE_RAIL_DB} DESTINATION "${CMAKE_INSTALL_DATADIR}/be-rail")
