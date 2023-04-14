#!/bin/bash

# clean everything
rm -f add_floats.h add_floats.cpp add_floats.dylib add_floats.py

# Create the C++ header file
cat > add_floats.h << EOF
extern "C" {
    float add_floats(float a, float b);
}
EOF

# Create the C++ source file
cat > add_floats.cpp << EOF
#include "add_floats.h"

float add_floats(float a, float b) {
    return a + b;
}
EOF

# Compile the C++ file into a shared library
g++ -shared -o add_floats.dylib add_floats.cpp

# Create the Python file
cat > add_floats.py << EOF
import ctypes

# Load the shared library
add_floats_lib = ctypes.CDLL('./add_floats.dylib')

# Define the argument types and return type of the add_floats function
add_floats_lib.add_floats.argtypes = [ctypes.c_float, ctypes.c_float]
add_floats_lib.add_floats.restype = ctypes.c_float

def add_floats(a, b):
    return add_floats_lib.add_floats(a, b)

# Test the function
result = add_floats(3.5, 2.5)
print(f"3.5 + 2.5 = {result}")
EOF

# Run the Python script
python3 add_floats.py
