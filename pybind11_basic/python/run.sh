#!/bin/bash

# clean all *.so files if argument is "clean"
if [ "$1" == "clean" ]; then
    rm -rfv build
    rm -fv *.so
fi

# check conda environment "pybind" is activated
if [ "$CONDA_DEFAULT_ENV" != "pybind" ]; then
    echo "Error: conda environment 'pybind' is not activated"
    exit 1
fi

python setup.py build_ext --inplace

# test the library build from scratch
python -c "import arith; print('[Raw]Add:', arith.add_floats(1, 2)); print('[Raw]Mult:', arith.mult_floats(1, 2))"

# test the library link dymically
DYLD_LIBRARY_PATH='../cpp/build/lib' python -c "import arith_dynamic; print('[Dyn]Add:', arith_dynamic.add_floats(1, 2)); print('[Dyn]Mult:', arith_dynamic.mult_floats(1, 2))"

# test the static library
python -c "import arith_static; print('[Sta]Add:', arith_static.add_floats(1, 2)); print('[Sta]Mult:', arith_static.mult_floats(1, 2))"
