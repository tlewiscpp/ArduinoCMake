cmake_minimum_required(VERSION 3.1)
if (NOT PROJECT_NAME)
    set (PROJECT_NAME ArduinoProject)
endif()

set (ARDUINO_CORE_LIB_DIR ${CMAKE_SOURCE_DIR}/toolchain/)

project(${PROJECT_NAME})

add_subdirectory(TestProject)

