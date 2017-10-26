include (${ARDUINO_CORE_LIB_DIR}/ArduinoCrossCompile.cmake)

cmake_minimum_required(VERSION 3.4)
set (PROJECT_NAME TestProject)

set (SOURCE_ROOT .)

set (PROJECT_FILE ${SOURCE_ROOT}/${PROJECT_NAME}.ino)

set (${PROJECT_NAME}_SOURCE_FILES
        ${PROJECT_FILE})

add_arduino_executable(
        TARGET ${PROJECT_NAME}
        SOURCE_FILES ${${PROJECT_NAME}_SOURCE_FILES}
        PROJECT_NAME ${PROJECT_NAME}
)