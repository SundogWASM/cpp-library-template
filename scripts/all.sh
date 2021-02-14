#!/bin/bash

rm -rf build
cmake -Hall -Bbuild -DCMAKE_TOOLCHAIN_FILE=${VCPKG_ROOT}/scripts/buildsystems/vcpkg.cmake
cmake --build build

# run tests
./build/test/GreeterTests
# format code
cmake --build build --target fix-format
# run standalone
./build/standalone/Greeter --help