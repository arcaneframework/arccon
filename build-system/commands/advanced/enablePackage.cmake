macro(enablePackage)

  set(options)
  set(oneValueArgs NAME)
  set(multiValueArgs)

  cmake_parse_arguments(ARGS "${options}" "${oneValueArgs}" "${multiValueArgs}" ${ARGN})

  if(ARGS_UNPARSED_ARGUMENTS)
    message(FATAL_ERROR "unparsed arguments '${ARGS_UNPARSED_ARGUMENTS}'")
  endif()

  if(NOT ARGS_NAME)
    message(FATAL_ERROR "enable_package error, name is undefined")
  endif()

  string(TOLOWER ${ARGS_NAME} package)

  unset(${package}_IS_DISABLED)
  unset(${package}_WHY)

endmacro()
