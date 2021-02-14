cmake -Htest -Bbuild/test
cmake --build build/test
CTEST_OUTPUT_ON_FAILURE=1 cmake --build build/test --target test

# or simply call the executable:
./build/test/GreeterTests
