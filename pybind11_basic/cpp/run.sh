#!/bin/bash

# if argument is clean then remove build directory
if [ "$1" == "clean" ]; then
    rm -rfv build
    echo "cleaned build directory"
fi

mkdir -p build && cd build || exit
cmake -DENABLE_TESTS=ON ..
cmake --build .
ctest --verbose .
