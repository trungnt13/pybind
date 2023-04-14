import ctypes

# Load the shared library
add_floats_lib = ctypes.CDLL('./add_floats.cpython-39-darwin.so')

# Define the argument types and return type of the add_floats function
add_floats_lib.add_floats.argtypes = [ctypes.c_float, ctypes.c_float]
add_floats_lib.add_floats.restype = ctypes.c_float

def add_floats(a, b):
    return add_floats_lib.add_floats(a, b)

# Test the function
result = add_floats(3.5, 2.5)
print(f"3.5 + 2.5 = {result}")
