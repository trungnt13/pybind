from setuptools import setup, Extension
from distutils.command.build_ext import build_ext
import os
import sys
import setuptools

# Define the extension module
extension_mod = Extension(
    "cmult",
    sources=["cpp/cmult.cpp"],
    include_dirs=["cpp"],
    libraries=["cmult"],
    library_dirs=["/usr/local/lib"],
)


# Define the build_ext command
class BuildExtCommand(build_ext):
    def run(self):
        # Check if swig is installed
        try:
            import swig
        except ImportError:
            print("Swig is not installed. Please install swig and try again.")
            sys.exit(1)

        # Run swig to generate the wrapper code
        swig_cmd = "swig -python -c++ my_cpp_module.i"
        os.system(swig_cmd)

        # Build the extension module
        build_ext.run(self)


# Setup the package
setup(
    name="my_cpp_module",
    version="1.0",
    description="C++ binding to Python using ctypes and swig",
    ext_modules=[extension_mod],
    cmdclass={"build_ext": BuildExtCommand},
)
