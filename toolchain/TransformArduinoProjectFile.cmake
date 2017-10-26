cmake_minimum_required(VERSION 3.4)

function(transform_arduino_project_file)
    set(FUNC_NAME transform_arduino_project_file)

    set(options)
    set(oneValueArgs TARGET FILE_NAME)
    set(multiValueArgs)

    cmake_parse_arguments(${FUNC_NAME} "${options}" "${oneValueArgs}" "${multiValueArgs}" ${ARGN} )

    if (${FUNC_NAME}_FILE_NAME)
        set(ITEM "${${FUNC_NAME}_FILE_NAME}")
    else()
        if ( NOT "${${FUNC_NAME}_UNPARSED_ARGUMENTS}" STREQUAL "")
            set(ITEM "${${FUNC_NAME}_UNPARSED_ARGUMENTS}")
        else()
            file(GLOB ITEM "*.ino *.pde")
        endif()
    endif()

    if ("${ITEM}" STREQUAL "")
        message(FATAL_ERROR "Please set FILE_NAME argument of transform_arduino_project_file to project file name (ex Test.ino)")
    endif()

    get_filename_component(ITEM "${ITEM}" NAME)



    add_custom_command(
            OUTPUT "${CMAKE_CURRENT_BINARY_DIR}/${ITEM_BASE}.cpp"
            COMMAND ${CMAKE_COMMAND} -E copy "${CMAKE_CURRENT_SOURCE_DIR}/${ITEM}" "${CMAKE_CURRENT_BINARY_DIR}/${ITEM}.cpp"
            DEPENDS "${CMAKE_CURRENT_SOURCE_DIR}/${ITEM}"
    )
    set(PROJECT_FILE_CPP ${ITEM}.cpp PARENT_SCOPE)

endfunction()
