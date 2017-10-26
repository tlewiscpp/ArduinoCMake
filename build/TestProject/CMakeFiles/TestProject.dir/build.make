# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.9

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:


#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:


# Remove some rules from gmake that .SUFFIXES does not remove.
SUFFIXES =

.SUFFIXES: .hpux_make_needs_suffix_list


# Suppress display of executed commands.
$(VERBOSE).SILENT:


# A target that is always out of date.
cmake_force:

.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /usr/bin/cmake

# The command to remove a file.
RM = /usr/bin/cmake -E remove -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /home/pinguinsan/Projects/ArduinoCMake

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/pinguinsan/Projects/ArduinoCMake/build

# Include any dependencies generated for this target.
include TestProject/CMakeFiles/TestProject.dir/depend.make

# Include the progress variables for this target.
include TestProject/CMakeFiles/TestProject.dir/progress.make

# Include the compile flags for this target's objects.
include TestProject/CMakeFiles/TestProject.dir/flags.make

TestProject/CMakeFiles/TestProject.dir/TestProject.ino.o: TestProject/CMakeFiles/TestProject.dir/flags.make
TestProject/CMakeFiles/TestProject.dir/TestProject.ino.o: ../TestProject/TestProject.ino
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/pinguinsan/Projects/ArduinoCMake/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building CXX object TestProject/CMakeFiles/TestProject.dir/TestProject.ino.o"
	cd /home/pinguinsan/Projects/ArduinoCMake/build/TestProject && avr-g++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS)  -xc++  -o CMakeFiles/TestProject.dir/TestProject.ino.o -c /home/pinguinsan/Projects/ArduinoCMake/TestProject/TestProject.ino

TestProject/CMakeFiles/TestProject.dir/TestProject.ino.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/TestProject.dir/TestProject.ino.i"
	cd /home/pinguinsan/Projects/ArduinoCMake/build/TestProject && avr-g++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS)  -xc++  -E /home/pinguinsan/Projects/ArduinoCMake/TestProject/TestProject.ino > CMakeFiles/TestProject.dir/TestProject.ino.i

TestProject/CMakeFiles/TestProject.dir/TestProject.ino.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/TestProject.dir/TestProject.ino.s"
	cd /home/pinguinsan/Projects/ArduinoCMake/build/TestProject && avr-g++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS)  -xc++  -S /home/pinguinsan/Projects/ArduinoCMake/TestProject/TestProject.ino -o CMakeFiles/TestProject.dir/TestProject.ino.s

TestProject/CMakeFiles/TestProject.dir/TestProject.ino.o.requires:

.PHONY : TestProject/CMakeFiles/TestProject.dir/TestProject.ino.o.requires

TestProject/CMakeFiles/TestProject.dir/TestProject.ino.o.provides: TestProject/CMakeFiles/TestProject.dir/TestProject.ino.o.requires
	$(MAKE) -f TestProject/CMakeFiles/TestProject.dir/build.make TestProject/CMakeFiles/TestProject.dir/TestProject.ino.o.provides.build
.PHONY : TestProject/CMakeFiles/TestProject.dir/TestProject.ino.o.provides

TestProject/CMakeFiles/TestProject.dir/TestProject.ino.o.provides.build: TestProject/CMakeFiles/TestProject.dir/TestProject.ino.o


# Object files for target TestProject
TestProject_OBJECTS = \
"CMakeFiles/TestProject.dir/TestProject.ino.o"

# External object files for target TestProject
TestProject_EXTERNAL_OBJECTS =

TestProject/TestProject: TestProject/CMakeFiles/TestProject.dir/TestProject.ino.o
TestProject/TestProject: TestProject/CMakeFiles/TestProject.dir/build.make
TestProject/TestProject: TestProject/libArduinoCore.a
TestProject/TestProject: TestProject/CMakeFiles/TestProject.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/home/pinguinsan/Projects/ArduinoCMake/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Linking CXX executable TestProject"
	cd /home/pinguinsan/Projects/ArduinoCMake/build/TestProject && $(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/TestProject.dir/link.txt --verbose=$(VERBOSE)
	cd /home/pinguinsan/Projects/ArduinoCMake/build/TestProject && avr-objcopy -O ihex -R .eeprom TestProject TestProject.hex
	cd /home/pinguinsan/Projects/ArduinoCMake/build/TestProject && echo -V -C/etc/avrdude.conf -carduino -pm328p -b115200 -P/dev/ttyACM0 -Uflash:w:TestProject.hex
	cd /home/pinguinsan/Projects/ArduinoCMake/build/TestProject && avrdude -V -C/etc/avrdude.conf -carduino -pm328p -b115200 -P/dev/ttyACM0 -Uflash:w:TestProject.hex

# Rule to build all files generated by this target.
TestProject/CMakeFiles/TestProject.dir/build: TestProject/TestProject

.PHONY : TestProject/CMakeFiles/TestProject.dir/build

TestProject/CMakeFiles/TestProject.dir/requires: TestProject/CMakeFiles/TestProject.dir/TestProject.ino.o.requires

.PHONY : TestProject/CMakeFiles/TestProject.dir/requires

TestProject/CMakeFiles/TestProject.dir/clean:
	cd /home/pinguinsan/Projects/ArduinoCMake/build/TestProject && $(CMAKE_COMMAND) -P CMakeFiles/TestProject.dir/cmake_clean.cmake
.PHONY : TestProject/CMakeFiles/TestProject.dir/clean

TestProject/CMakeFiles/TestProject.dir/depend:
	cd /home/pinguinsan/Projects/ArduinoCMake/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/pinguinsan/Projects/ArduinoCMake /home/pinguinsan/Projects/ArduinoCMake/TestProject /home/pinguinsan/Projects/ArduinoCMake/build /home/pinguinsan/Projects/ArduinoCMake/build/TestProject /home/pinguinsan/Projects/ArduinoCMake/build/TestProject/CMakeFiles/TestProject.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : TestProject/CMakeFiles/TestProject.dir/depend

