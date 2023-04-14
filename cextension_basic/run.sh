#!/bin/bash

# the double dash "--" tells rm to stop processing arguments as options
rm -rfv -- build *.so *.o *.dSYM cppmult

# Note: This $(python3.8-config --include) will work but "$(python3.8-config --include)" will not work

# clang++ -fcolor-diagnostics -fansi-escape-codes -g /Users/trungnt13/codes/pybind/cython_basic/cppmult.cpp -o /Users/trungnt13/codes/pybind/cython_basic/cppmult

# executable file
g++ -stdlib=libc++ -std=c++17 -undefined dynamic_lookup $(python3.8-config --include) -o cppmult cppmult.cpp

# object file
g++ -stdlib=libc++ -std=c++17 -c cppmult.cpp $(python3.8-config --include) -o cppmult.o

./cppmult

python setup.py build_ext --inplace
python -c "import cppmult; print(cppmult.cppmult(1, 2))"
