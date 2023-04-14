from setuptools import setup, Extension
from setuptools.command.build_ext import build_ext
import sys
import os


class BuildExtension(build_ext):
    def run(self):
        # Run the original build_ext command
        build_ext.run(self)


# Define the extension module
add_floats_module = Extension(
    "add_floats", sources=["add_floats.cpp"], extra_compile_args=["-std=c++11"], language="c++"
)

# Run the setup
setup(
    name="add_floats",
    version="0.1",
    description="A ctypes C++ binding example",
    ext_modules=[add_floats_module],
    cmdclass={"build_ext": BuildExtension},
)
