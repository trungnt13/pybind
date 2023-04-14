# downlaod googletest to thirdparty/googletest
set(GTEST_ROOT ${CMAKE_CURRENT_SOURCE_DIR}/thirdparty/googletest)
set(GTEST_BINARY_DIR ${GTEST_ROOT}/build)

if(NOT EXISTS ${GTEST_ROOT})
  execute_process(
    COMMAND git clone https://github.com/google/googletest
    WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/thirdparty
    RESULT_VARIABLE GTEST_CLONE_RESULT)
  execute_process(
    COMMAND git checkout v1.13.0
    WORKING_DIRECTORY ${GTEST_ROOT}
    RESULT_VARIABLE GTEST_CHECKOUT_RESULT)

  if(NOT GTEST_CLONE_RESULT EQUAL 0 OR NOT GTEST_CHECKOUT_RESULT EQUAL 0)
    message(FATAL_ERROR "Failed to clone googletest")
  endif()

endif()

if(NOT EXISTS ${GTEST_BINARY_DIR})
  file(MAKE_DIRECTORY ${GTEST_BINARY_DIR})

  # configure the project
  execute_process(
    COMMAND ${CMAKE_COMMAND} ${GTEST_ROOT}
    WORKING_DIRECTORY ${GTEST_BINARY_DIR}
    RESULT_VARIABLE GTEST_CMAKE_CONFIG_RESULT)

  # build the project
  execute_process(
    COMMAND ${CMAKE_COMMAND} --build .
    WORKING_DIRECTORY ${GTEST_BINARY_DIR}
    RESULT_VARIABLE GTEST_CMAKE_BUILD_RESULT)

  if(NOT GTEST_CMAKE_CONFIG_RESULT EQUAL 0 OR NOT GTEST_CMAKE_BUILD_RESULT
                                              EQUAL 0)
    file(REMOVE_RECURSE ${GTEST_BINARY_DIR})
    message(FATAL_ERROR "Failed to configure and build googletest")
  endif()

endif()

# add googletest to the project
set(GTEST_SOURCE_DIR ${GTEST_ROOT}/googletest)
set(GTEST_INCLUDE_DIRS ${GTEST_SOURCE_DIR}/include)
set(GTEST_LIBRARY_DIR ${GTEST_ROOT}/build/lib)
