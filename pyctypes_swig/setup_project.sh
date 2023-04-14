#!/bin/bash

# clean everything
rm -f add_floats.h add_floats.cpp add_floats.dylib add_floats_test.py

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

# create a SWIG interface file
cat > add_floats.i << EOF
%module add_floats

%{
#include "add_floats.h"
%}

%include "add_floats.h"
EOF

# Compile the C++ file
clang++ -arch arm64 -c -fpic add_floats.cpp -o add_floats.o

# Generate the SWIG wrapper
swig -c++ -python add_floats.i

# Compile the SWIG wrapper
clang++ -arch arm64 -c -fpic add_floats_wrap.cxx -I "$(python -c "import sysconfig; print(sysconfig.get_path('include'))")" -o add_floats_wrap.o

# Link the object files and create the shared library
clang++ -arch arm64 -shared add_floats.o add_floats_wrap.o -o _add_floats.so -undefined dynamic_lookup

# Clean up the temporary files
rm add_floats.o add_floats_wrap.cxx add_floats_wrap.o

# Create the Python file
cat > add_floats_test.py << EOF
import add_floats

result = add_floats.add_floats(3.5, 2.5)
print("The sum of 3.5 and 2.5 is:", result)
EOF

# Run the Python script
python add_floats_test.py
