"""
python -c "import sysconfig; print(sysconfig.get_path('include'))"
# /Users/trungnt13/miniconda3/envs/pybind/include/python3.8
g++ -shared -fPIC \
    -I$(python -c "import sysconfig; print(sysconfig.get_path('include'))") \
    -Icpp \
    python/cmult_wrap.cxx \
    cpp/cmult.cpp -o libcmult.dylib

clang++ -shared -fPIC -arch arm64 -undefined dynamic_lookup \
    -I "$(python -c "import sysconfig; print(sysconfig.get_path('include'))")" \
    ../cpp/out/build/libcmult.dylib cmult_wrap.cxx -o _cmult.so
"""
import ctypes

# Load the shared library
dll = ctypes.CDLL("cpp/out/build/libcmult.dylib")
print(dir(dll))

# Load the shared library
# dll = ctypes.CDLL('cpp/libtest.so')
# print(dir(dll))

# Define the argument types and return type of the add function
dll.cmult.argtypes = [ctypes.c_int, ctypes.c_float]
dll.cmult.restype = ctypes.c_float

# Call the add function
result = dll.cmult(3, 4)
print(result)
