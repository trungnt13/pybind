cmake_minimum_required(VERSION 3.20)
project(cpp_arithmetic VERSION 0.1.0)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_VERBOSE_MAKEFILE ON)

# User options (cmake -DENABLE_TESTS=OFF ..); use `cmake -LH ..` to list all
# options
option(ENABLE_TESTS "Build unit tests" ON)

# Prepare the source and headers (it is recommended to do this manually)
file(GLOB_RECURSE SOURCE_FILES "${CMAKE_CURRENT_SOURCE_DIR}/src/*.cpp")
include_directories(${CMAKE_CURRENT_SOURCE_DIR}/include)

# BUild the static library
add_library(arith_static STATIC ${SOURCE_FILES})
set_property(TARGET arith_static PROPERTY ARCHIVE_OUTPUT_DIRECTORY
                                          ${CMAKE_BINARY_DIR}/lib)
# Build the share library
add_library(arith SHARED ${SOURCE_FILES})
set_property(TARGET arith PROPERTY LIBRARY_OUTPUT_DIRECTORY
                                   ${CMAKE_BINARY_DIR}/lib)
# configure the libraries
set(ALL_LIBRARIES arith arith_static)
foreach(LIB ${ALL_LIBRARIES})
  # position-independent code (PIC)
  set_property(TARGET ${LIB} PROPERTY POSITION_INDEPENDENT_CODE ON)
  # interprocedural optimization (IPO): allowing the compiler to optimize across
  # different translation units, but increase build time and memory usage.
  set_property(TARGET ${LIB} PROPERTY INTERPROCEDURAL_OPTIMIZATION ON)
  # -O3 to enable aggressive optimizations, or -fno-exceptions to disable C++
  # exceptions.
  target_compile_options(${LIB} PRIVATE -O3 -fno-exceptions)
endforeach()

# Prepare GoogleTest
include(thirdparty/get_gtest.cmake)

# Build the unit tests
if(EXISTS ${GTEST_LIBRARY_DIR} AND ENABLE_TESTS)
  enable_testing()
  # Extract all unit tests files
  file(GLOB_RECURSE UNIT_TEST_SOURCE "${CMAKE_CURRENT_SOURCE_DIR}/tests/*.cpp")
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
  target_link_libraries(all_tests gtest gtest_main arith)
  # add the test to the ctest suite
  add_test(AllTestsInUnitTests ${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/all_tests)
else()
  message(
    STATUS
      "GoogleTest not found or ENABLE_TESTS=${ENABLE_TESTS}, tests disabled")
endif()
