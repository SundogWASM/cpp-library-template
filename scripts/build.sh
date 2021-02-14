#!/bin/bash

rm -rf build
cmake -DBUILD_TESTING=OFF -S . -B build -DCMAKE_TOOLCHAIN_FILE=${VCPKG_ROOT}/scripts/buildsystems/vcpkg.cmake -DBUILD_TESTING=OFF
cmake --build build -j
