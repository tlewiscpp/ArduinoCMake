cmake_minimum_required(VERSION 3.4)
set (ARDUINO_CORE_PROJECT_NAME ArduinoCore)

set(ENABLE_EXPORTS FALSE)

if (NOT ARDUINO_CORE_ROOT)
    if (IS_DIRECTORY "/usr/share/arduino")
        set(ARDUINO_CORE_ROOT "/usr/share/arduino")
    else()
        message (FATAL_ERROR "Please define ARDUINO_CORE_ROOT as -DARDUINO_CORE_ROOT=/path/to/arduino/core/ (ex /usr/share/arduino/)")
    endif()
endif()

if (EXISTS ${ARDUINO_CORE_ROOT}/hardware/archlinux-arduino/avr/cores/arduino/)
    set (ARDUINO_CORE_SOURCES "${ARDUINO_CORE_ROOT}/hardware/archlinux-arduino/avr/cores/arduino/")
elseif (EXISTS ${ARDUINO_CORE_ROOT}/hardware/arduino/avr/cores/arduino/)
    set (ARDUINO_CORE_SOURCES "${ARDUINO_CORE_ROOT}/hardware/arduino/avr/cores/arduino/")
else()
    message(FATAL_ERROR "Searched directories for arduino cores failed!")
endif()


set(BOARD_TYPE_TEMP ${ARDUINO_BOARD_TYPE})
string(TOUPPER "${BOARD_TYPE_TEMP}" BOARD_TYPE)

if (NOT BOARD_TYPE)
    message(FATAL_ERROR "Please define ARDUINO_BOARD_TYPE (ie UNO, MEGA, etc)")
endif()

if ("${BOARD_TYPE}" STREQUAL "UNO")
    include(${ARDUINO_CORE_LIB_DIR}/ArduinoUnoCrossCompile.cmake)
    set (ARDUINO_VARIANT_PINS_DIR "${ARDUINO_CORE_SOURCES}/../../variants/standard/")
elseif("${BOARD_TYPE}" STREQUAL "MEGA")
    set (ARDUINO_VARIANT_PINS_DIR "${ARDUINO_CORE_SOURCES}/../../variants/mega/")
    include(${ARDUINO_CORE_LIB_DIR}/ArduinoMegaCrossCompile.cmake)
elseif("${BOARD_TYPE}" STREQUAL "LEONARDO")
    set (ARDUINO_VARIANT_PINS_DIR "${ARDUINO_CORE_SOURCES}/../../variants/leonardo/")
    include(${ARDUINO_CORE_LIB_DIR}/arduino_leonardo_crosscompile.cmake)
else()
    message(FATAL_ERROR "Unsupported board type ${ARDUINO_BOARD_TYPE}")
endif()


set (${ARDUINO_CORE_PROJECT_NAME}_HEADER_FILES
        "${ARDUINO_CORE_SOURCES}/HardwareSerial_private.h"
        "${ARDUINO_CORE_SOURCES}/Print.h"
        "${ARDUINO_CORE_SOURCES}/Arduino.h"
        "${ARDUINO_CORE_SOURCES}/Server.h"
        "${ARDUINO_CORE_SOURCES}/binary.h"
        "${ARDUINO_CORE_SOURCES}/IPAddress.h"
        "${ARDUINO_CORE_SOURCES}/Stream.h"
        "${ARDUINO_CORE_SOURCES}/Client.h"
        "${ARDUINO_CORE_SOURCES}/main.cpp"
        "${ARDUINO_CORE_SOURCES}/Tone.cpp"
        "${ARDUINO_CORE_SOURCES}/wiring_private.h"
        "${ARDUINO_CORE_SOURCES}/Udp.h"
        "${ARDUINO_CORE_SOURCES}/new.h"
        "${ARDUINO_CORE_SOURCES}/USBAPI.h"
        "${ARDUINO_CORE_SOURCES}/PluggableUSB.h"
        "${ARDUINO_CORE_SOURCES}/USBCore.h"
        "${ARDUINO_CORE_SOURCES}/Printable.h"
        "${ARDUINO_CORE_SOURCES}/USBDesc.h"
        "${ARDUINO_CORE_SOURCES}/HardwareSerial.h"
        "${ARDUINO_CORE_SOURCES}/WCharacter.h"
        "${ARDUINO_CORE_SOURCES}/WString.h")

set (${ARDUINO_CORE_PROJECT_NAME}_SOURCE_FILES
        "${ARDUINO_CORE_SOURCES}/IPAddress.cpp"
        "${ARDUINO_CORE_SOURCES}/Stream.cpp"
        "${ARDUINO_CORE_SOURCES}/HardwareSerial.cpp"
        "${ARDUINO_CORE_SOURCES}/HardwareSerial0.cpp"
        "${ARDUINO_CORE_SOURCES}/HardwareSerial1.cpp"
        "${ARDUINO_CORE_SOURCES}/HardwareSerial2.cpp"
        "${ARDUINO_CORE_SOURCES}/HardwareSerial3.cpp"
        "${ARDUINO_CORE_SOURCES}/WString.cpp"
        "${ARDUINO_CORE_SOURCES}/PluggableUSB.cpp"
        "${ARDUINO_CORE_SOURCES}/USBCore.cpp"
        "${ARDUINO_CORE_SOURCES}/new.cpp"
        "${ARDUINO_CORE_SOURCES}/abi.cpp"
        "${ARDUINO_CORE_SOURCES}/Print.cpp"
        "${ARDUINO_CORE_SOURCES}/WInterrupts.c"
        "${ARDUINO_CORE_SOURCES}/hooks.c"
        "${ARDUINO_CORE_SOURCES}/wiring_digital.c"
        "${ARDUINO_CORE_SOURCES}/wiring.c"
        "${ARDUINO_CORE_SOURCES}/CDC.cpp"
        "${ARDUINO_CORE_SOURCES}/wiring_analog.c"
        "${ARDUINO_CORE_SOURCES}/WMath.cpp"
        "${ARDUINO_CORE_SOURCES}/wiring_pulse.S"
        "${ARDUINO_CORE_SOURCES}/wiring_shift.c"
        "${ARDUINO_CORE_SOURCES}/wiring_pulse.c")


add_library (${ARDUINO_CORE_PROJECT_NAME} STATIC
        ${${ARDUINO_CORE_PROJECT_NAME}_SOURCE_FILES})

target_include_directories(${ARDUINO_CORE_PROJECT_NAME}
        PUBLIC ${CMAKE_CURRENT_SOURCE_DIR}
        PUBLIC ${ARDUINO_CORE_ROOT}
        PUBLIC ${ARDUINO_CORE_SOURCES}
        PUBLIC ${ARDUINO_VARIANT_PINS_DIR})

set_target_properties(${ARDUINO_CORE_PROJECT_NAME} PROPERTIES ENABLE_EXPORTS FALSE)

function(add_arduino_executable)
    set(FUNC add_arduino_executable)

    set(options)
    set(oneValueArgs TARGET SOURCE_FILES)
    set(multiValueArgs)

    cmake_parse_arguments(${FUNC} "${options}" "${oneValueArgs}" "${multiValueArgs}" ${ARGN} )

    set_property(SOURCE ${${FUNC}_TARGET}.ino APPEND_STRING PROPERTY COMPILE_FLAGS " -xc++ ")
    set_source_files_properties(${${FUNC}_SOURCE_FILES} PROPERTIES LANGUAGE CXX)

    if (NOT ${FUNC}_TARGET)
        set(${FUNC}_TARGET ${${FUNC}_UNPARSED_ARGUMENTS})
    endif()

    add_executable(${${FUNC}_TARGET}
            ${${FUNC}_SOURCE_FILES})

    target_link_libraries(${${FUNC}_TARGET} ArduinoCore)

    target_include_directories(${${FUNC}_TARGET}
            PUBLIC ${CMAKE_CURRENT_SOURCE_DIR}
            PUBLIC ${ARDUINO_CORE_LIB_ROOT})

    add_custom_command(TARGET ${${FUNC}_TARGET}
            POST_BUILD
            COMMAND avr-objcopy ARGS -O ihex -R .eeprom ${${FUNC}_TARGET} ${${FUNC}_TARGET}.hex)

    set (UPLOAD_COMMAND "avrdude")

    #Built in Arduino:  sudo avrdude -V -c stk500v1 -p m328p -b 19200 -P /dev/ttyUSB0 -U flash:w:output.hex
    #USBTiny programmer: sudo avrdude -V -c usbtiny -p m328p -U flash:w:output.hex
        #USB

    if ("${PROGRAMMER}" STREQUAL "usbtiny")
        set(UPLOAD_ARGS -V -C/etc/avrdude.conf -c${PROGRAMMER} -p${AVRDUDE_ID} -Uflash:w:${${FUNC}_TARGET}.hex)
    elseif ("${PROGRAMMER}" STREQUAL "buspirate")
        if (NOT PORT)
            if (EXISTS "/dev/ttyUSB0")
                set(PORT "/dev/ttyUSB0")
            elseif (EXISTS "/dev/ttyUSB1")
                set(PORT "/dev/ttyUSB1")
            elseif (EXISTS "/dev/ttyUSB2")
                set(PORT "/dev/ttyUSB2")
            else()
                message(FATAL_ERROR "Please define PORT (serial port for buspirate programmer)")
            endif()
        endif()
        set(UPLOAD_BAUD_RATE "115200")
        set(UPLOAD_ARGS -V -C/etc/avrdude.conf -c${PROGRAMMER} -p${AVRDUDE_ID} -b${UPLOAD_BAUD_RATE} -P${PORT} -Uflash:w:${${FUNC}_TARGET}.hex)
    elseif(NOT PROGRAMMER)
        if (NOT PORT)
            if (EXISTS "/dev/ttyACM0")
                set(PORT "/dev/ttyACM0")
            elseif (EXISTS "/dev/ttyACM1")
                set(PORT "/dev/ttyACM1")
            elseif (EXISTS "/dev/ttyACM2")
                set(PORT "/dev/ttyACM2")
            elseif (EXISTS "/dev/ttyUSB0")
                set(PORT "/dev/ttyUSB0")
            elseif (EXISTS "/dev/ttyUSB1")
                set(PORT "/dev/ttyUSB1")
            elseif (EXISTS "/dev/ttyUSB2")
                set(PORT "/dev/ttyUSB2")
            else()
                message(FATAL_ERROR "Please define PORT (serial port for arduino)")
            endif()
        endif()
        set(PROGRAMMER arduino)
        set(UPLOAD_ARGS -V -C/etc/avrdude.conf -c${PROGRAMMER} -p${AVRDUDE_ID} -b${UPLOAD_BAUD_RATE} -P${PORT} -Uflash:w:${${FUNC}_TARGET}.hex)
    else()
        message(FATAL_ERROR "Specified programmer \"${PROGRAMMER}\" is not supported at this time")
    endif()

        message(STATUS "UPLOAD_ARGS = ${UPLOAD_ARGS}")

    add_custom_command(TARGET ${${FUNC}_TARGET}
            POST_BUILD
            COMMAND echo ARGS ${UPLOAD_ARGS})

    add_custom_command(TARGET ${${FUNC}_TARGET}
            POST_BUILD
            COMMAND ${UPLOAD_COMMAND} ARGS ${UPLOAD_ARGS})

endfunction()
