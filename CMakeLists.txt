cmake_minimum_required(VERSION 3.1.0)

project(be-rail)

set(STR_VERSION "0.2.0")

if(WIN32)
  set(CMAKE_INSTALL_BINDIR "${CMAKE_INSTALL_PREFIX}/be-rail/bin")
  if(NOT DATADIR)
    set(DATADIR "../db")
  endif()
  if(NOT TRANSLATIONS_DIR)
    set(TRANSLATIONS_DIR "../translations")
  endif()
else()
  include(GNUInstallDirs)
  if(NOT DATADIR)
    set(DATADIR "${CMAKE_INSTALL_FULL_DATADIR}/be-rail")
  endif()
  if(NOT TRANSLATIONS_DIR)
    set(TRANSLATIONS_DIR "${DATADIR}/translations")
  endif()
endif()

set(EXE_NAME be-rail)

file (GLOB BE_RAIL_TS translations/*.ts)

set(BE_RAIL_DB db/be-rail.sqlite)

set(EXECUTABLE_OUTPUT_PATH ${CMAKE_HOME_DIRECTORY}/build)

if(NOT CMAKE_BUILD_TYPE)
    set(CMAKE_BUILD_TYPE Release)
endif()

# make package_source target
set(CPACK_PACKAGE_NAME "be-rail")
set(CPACK_PACKAGE_VERSION "${STR_VERSION}")
set(CPACK_SOURCE_GENERATOR "TXZ;ZIP")
set(CPACK_SOURCE_PACKAGE_FILE_NAME "${CPACK_PACKAGE_NAME}-${CPACK_PACKAGE_VERSION}")
set(CPACK_SOURCE_IGNORE_FILES "/cache/;/build/;/CMakeFiles/;/_CPack_Packages/;/\\\\.git/;cmake$;depends$;Makefile;\\\\.zip$;tar\\\\.xz$;tar\\\\.bz2$;CMakeCache.txt;csv$")
include(CPack)

# make db/be-rail.sqlite
add_custom_target(db COMMAND rm cache/*htm COMMAND scripts/build-db.sh)

# simulate autotools' "make dist"
add_custom_target(dist COMMAND ${CMAKE_MAKE_PROGRAM} package_source)


add_definitions(-DDATADIR=\"${DATADIR}\")
add_definitions(-DTRANSLATIONS_DIR=\"${TRANSLATIONS_DIR}\")
add_definitions(-DSTR_VERSION=\"${STR_VERSION}\")

add_subdirectory(src)

install(FILES be-rail.desktop DESTINATION "${CMAKE_INSTALL_DATADIR}/applications")
install(FILES be-rail.png DESTINATION "${CMAKE_INSTALL_DATADIR}/pixmaps")
install(FILES ${BE_RAIL_DB} DESTINATION "${CMAKE_INSTALL_DATADIR}/be-rail")
