set(RES_FILES "")
# This sets up the exe icon for windows under mingw.
if(MINGW)
  set(RES_FILES "be-rail.rc")
  set(CMAKE_RC_COMPILER_INIT windres)
  ENABLE_LANGUAGE(RC)
  set(CMAKE_RC_COMPILE_OBJECT "<CMAKE_RC_COMPILER> <FLAGS> -O coff <DEFINES> -i <SOURCE> -o <OBJECT>")
endif(MINGW)

# Find includes in corresponding build directories
set(CMAKE_INCLUDE_CURRENT_DIR ON)
# Instruct CMake to run moc automatically when needed.
set(CMAKE_AUTOMOC ON)

# Find the QtWidgets library
find_package(Qt5Widgets REQUIRED)
find_package(Qt5Sql REQUIRED)
find_package(Qt5LinguistTools REQUIRED)

message(STATUS "Qt version: ${Qt5Core_VERSION_STRING}")

set(be-rail_RESOURCES icons.qrc)
qt5_add_resources(be-rail_RESOURCES_RCC ${be-rail_RESOURCES})
qt5_add_translation(BE_RAIL_QM ${BE_RAIL_TS})

# Tell CMake to create the be-rail executable
add_executable(${EXE_NAME} WIN32 main.cpp mainwindow.cpp ${be-rail_RESOURCES_RCC} ${RES_FILES} ${BE_RAIL_QM})

# Use the Widgets module from Qt 5.
target_link_libraries(${EXE_NAME} Qt5::Widgets Qt5::Sql)


install(TARGETS ${EXE_NAME} DESTINATION "${CMAKE_INSTALL_BINDIR}")
install(FILES ${BE_RAIL_QM} DESTINATION ${TRANSLATIONS_DIR})
