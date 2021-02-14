cmake_minimum_required(VERSION 3.14 FATAL_ERROR)

project(GreeterTests LANGUAGES CXX)

# ---- Options ----

option(ENABLE_TEST_COVERAGE "Enable test coverage" OFF)
option(TEST_INSTALLED_VERSION "Test the version found by find_package" OFF)

# --- Import tools ----

include(../cmake/tools.cmake)

# ---- Create binary ----

file(GLOB sources
    CONFIGURE_DEPENDS
    ${CMAKE_CURRENT_SOURCE_DIR}/source/*.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/../source/*.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/../source/fontrush/*.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/../include/*.h
    ${CMAKE_CURRENT_SOURCE_DIR}/../include/greeter/*.h
    ${CMAKE_CURRENT_SOURCE_DIR}/../include/greeter/fontrush/*.h
)

add_executable(GreeterTests ${sources})
target_compile_features(GreeterTests PRIVATE cxx_std_17)

# ---- Dependencies ----

find_package(doctest CONFIG REQUIRED)
target_link_libraries(GreeterTests doctest::doctest Greeter::Greeter)

set_target_properties(GreeterTests PROPERTIES CXX_STANDARD 17)

# enable compiler warnings
if(NOT TEST_INSTALLED_VERSION)
  if(CMAKE_CXX_COMPILER_ID MATCHES "Clang" OR CMAKE_CXX_COMPILER_ID MATCHES "GNU")
    target_compile_options(Greeter PUBLIC -Wall -pedantic -Wextra -Werror)
  elseif(MSVC)
    target_compile_options(Greeter PUBLIC /W4 /WX)
    target_compile_definitions(GreeterTests PUBLIC DOCTEST_CONFIG_USE_STD_HEADERS)
  endif()
endif()

# ---- Add GreeterTests ----

enable_testing()

# Note: doctest and similar testing frameworks can automatically configure CMake tests For other
# testing frameworks add the tests target instead: ADD_TEST(GreeterTests GreeterTests)

include(${CMAKE_CURRENT_SOURCE_DIR}/../cmake/doctest.cmake)
doctest_discover_tests(GreeterTests)

# ---- code coverage ----

if(ENABLE_TEST_COVERAGE)
  target_compile_options(Greeter PUBLIC -O0 -g -fprofile-arcs -ftest-coverage)
  target_link_options(Greeter PUBLIC -fprofile-arcs -ftest-coverage)
endif()
