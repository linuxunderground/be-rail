# Find includes in corresponding build directories
set(CMAKE_INCLUDE_CURRENT_DIR ON)
# Instruct CMake to run moc automatically when needed.
set(CMAKE_AUTOMOC ON)

# Find the QtWidgets library
find_package(Qt5Widgets REQUIRED)
find_package(Qt5Sql REQUIRED)

message(STATUS "Qt version: ${Qt5Core_VERSION_STRING}")

# Tell CMake to create the be-rail executable
add_executable(be-rail main.cpp mainwindow.cpp)

# Use the Widgets module from Qt 5.
target_link_libraries(be-rail Qt5::Widgets Qt5::Sql)


install(TARGETS be-rail DESTINATION "${CMAKE_INSTALL_BINDIR}")
