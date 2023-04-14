#!/bin/bash

# check if conda environement "pybind" is activated
if [ -z "$CONDA_DEFAULT_ENV" ] || [ "$CONDA_DEFAULT_ENV" != "pybind" ]; then
    echo "Please activate conda environment 'pybind' first"
    exit 1
fi

# Install pybind11
rm -rfv add_floats*

# Create C++ source and header files
echo '#pragma once

float add(float a, float b);' > add_floats.h

echo '#include "add_floats.h"

float add(float a, float b) {
    return a + b;
}' > add_floats.cpp

# Create binding file
echo '#include <pybind11/pybind11.h>
#include "add_floats.h"

namespace py = pybind11;

PYBIND11_MODULE(add_floats_py, m) {
    m.doc() = "Add two floats using C++";
    m.def("add", &add, "Add two floats");
}' > add_floats_binding.cpp

# Compile the C++ library and binding
# c++ -O3 -Wall -shared -std=c++11 -fPIC -undefined dynamic_lookup "$(python3.8 -m pybind11 --includes)" add_floats.cpp add_floats_binding.cpp -o "add_floats_py$(python3.8-config --extension-suffix)"
c++ -O3 -Wall -shared -std=c++11 -fPIC -undefined dynamic_lookup -I/Users/trungnt13/miniconda3/envs/pybind/include/python3.8 -I/Users/trungnt13/miniconda3/envs/pybind/lib/python3.8/site-packages/pybind11/include add_floats.cpp add_floats_binding.cpp -o "add_floats_py$(python3.8-config --extension-suffix)"

# Test the library in Python
echo 'import add_floats_py

a = 3.5
b = 2.7
result = add_floats_py.add(a, b)
print(f"{a} + {b} = {result}")' > add_floats_test.py

python add_floats_test.py
