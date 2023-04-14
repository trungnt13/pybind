cmake_minimum_required(VERSION 3.10)
project(cmult)

set(CMAKE_CXX_STANDARD 14)
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -arch arm64")
set(CMAKE_VERBOSE_MAKEFILE ON)

message(STATUS "CMAKE_CXX_FLAGS: ${CMAKE_CXX_FLAGS}")

# Build the share library
add_library(cmult SHARED cmult.cpp)

# Unit tests
set(GTEST_ROOT ${CMAKE_CURRENT_SOURCE_DIR}/../third_party/googletest)
set(GTEST_SOURCE_DIR ${GTEST_ROOT}/googletest)
set(GTEST_INCLUDE_DIRS ${GTEST_SOURCE_DIR}/include)
set(GTEST_LIBRARY_DIR ${GTEST_ROOT}/build/lib)

execute_process(COMMAND realpath ${GTEST_ROOT}
                OUTPUT_VARIABLE GTEST_ROOT_REALPATH)
message("The real path of GTEST_ROOT is '${GTEST_ROOT_REALPATH}'")

message(STATUS "GTest root: ${GTEST_ROOT}")
message(STATUS "GTest source dir: ${GTEST_SOURCE_DIR}")
message(STATUS "GTest include dir: ${GTEST_INCLUDE_DIRS}")
message(STATUS "GTest library dir: ${GTEST_LIBRARY_DIR}")

if(EXISTS ${GTEST_LIBRARY_DIR})
  enable_testing()

  # Extract all unit tests files
  file(GLOB_RECURSE UNIT_TEST_SOURCE "*_test.cpp")
  message(STATUS "Test files: ${UNIT_TEST_SOURCE}")
  add_executable(all_tests ${UNIT_TEST_SOURCE})

  # add googletest as a static library
  add_library(gtest STATIC IMPORTED)
  set_target_properties(gtest PROPERTIES IMPORTED_LOCATION
                                         ${GTEST_LIBRARY_DIR}/libgtest.a)
  add_library(gtest_main STATIC IMPORTED)
  set_target_properties(
    gtest_main PROPERTIES IMPORTED_LOCATION
                          ${GTEST_LIBRARY_DIR}/libgtest_main.a)

  # link with googletest and the project library
  target_include_directories(all_tests PRIVATE ${GTEST_INCLUDE_DIRS})
  target_link_libraries(all_tests gtest gtest_main cmult)
  add_test(AllTestsInUnitTests ${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/all_tests)
else()
  message(STATUS "GTest not found at ${GTEST_ROOT}, skip unit tests")
endif()
