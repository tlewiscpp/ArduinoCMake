set(CMAKE_SYSTEM_NAME Generic)

set(CMAKE_C_COMPILER avr-gcc)
set(CMAKE_CXX_COMPILER avr-g++)

set(CSTANDARD "-std=gnu11")
set(CDEBUG "-gstabs")
set(CWARN "-Wall -Wstrict-prototypes")
set(CTUNING "-funsigned-char -funsigned-bitfields -fpack-struct -fshort-enums -fpermissive -fno-exceptions -ffunction-sections -fdata-sections -fno-threadsafe-statics  -flto -fno-devirtualize -fno-use-cxa-atexit")
set(COPT "-Os")
set(CINCS "-I${ARDUINO_CORE_SOURCES}")
set(CMCU "-mmcu=atmega328")
set(CDEFS "-DF_CPU=16000000 -DCMAKE_BUILD")
set(AVRDUDE_ID m328p)
set(UPLOAD_BAUD_RATE 115200)

set(CFLAGS "${CMCU} ${CDEBUG} ${CDEFS} ${CINCS} ${COPT} ${CWARN} ${CSTANDARD} ${CEXTRA}")
set(CXXFLAGS "${CMCU} ${CDEFS} ${CINCS} ${COPT}")

set(CMAKE_C_FLAGS  ${CFLAGS})
set(CMAKE_CXX_FLAGS ${CXXFLAGS})
