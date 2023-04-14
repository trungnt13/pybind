"""
Shared libraries are dynamically linked to a program or library at runtime,
while static libraries are statically linked to a program or library at compile time.

When a shared library is linked to a program, the linker creates a reference to the library in the program's executable file. At runtime, when the program is executed, the dynamic linker loads the shared library into memory and resolves the references to the library's functions and symbols. This allows multiple programs to share the same copy of the library in memory, reducing the overall memory usage of the system.

On the other hand, when a static library is linked to a program, the linker copies the object code from the library into the executable file of the program. This means that each program that links against the static library has its own copy of the library's object code in its executable file. This can result in larger executable files and higher memory usage, but it also ensures that the program will always use the exact same version of the library, even if a newer version of the library is installed on the system.

The choice between using shared libraries and static libraries depends on the specific requirements of the project. Shared libraries are usually preferred when multiple programs will be using the same library, or when the library is likely to be updated frequently. Static libraries are usually preferred when the library is small and stable, or when the program needs to be self-contained and not depend on external libraries.

For dynamic library: use library_dirs and libraries
For static library: use extra_objects

---
Once the compiler has found the header file, it uses the declarations and definitions in the header file to generate object code for your Python extension module. The object code is then passed to the linker, which combines it with other object code and libraries to create the final executable or shared library.

In summary, include directories are only used by the compiler during the build process to locate header files. They are not needed during runtime.
"""
import os
from setuptools import setup, Extension
from setuptools.command.build_ext import build_ext
import sys
import setuptools
import pybind11

__version__ = "0.1.0"

# 1. `include_dirs` are only used by the compiler during the build process to locate header files. They are not needed during runtime.
# 2. For dynamic library: use `library_dir` and `libraries`
# 3. For static library: use `extra_objects`
# DYLD_LIBRARY_PATH=../cpp/build/lib
ext_modules = [
    Extension(
        "arith",
        sources=["bindings.cpp", "../cpp/src/add_floats.cpp", "../cpp/src/mult_floats.cpp"],
        include_dirs=[pybind11.get_include(), "../cpp/include"],
    ),
    Extension(
        "arith_dynamic",
        sources=["bindings.cpp"],
        include_dirs=[pybind11.get_include(), "../cpp/include"],
        libraries=["arith"],
        library_dirs=["../cpp/build/lib"],
        define_macros=[("MODULE_NAME", "arith_dynamic")],
    ),
    Extension(
        "arith_static",
        sources=["bindings.cpp"],
        include_dirs=[pybind11.get_include(), "../cpp/include"],
        extra_objects=["../cpp/build/lib/libarith_static.a"],
        define_macros=[("MODULE_NAME", "arith_static")],
    ),
]


class BuildExt(build_ext):
    def build_extensions(self):
        ct = self.compiler.compiler_type
        if ct == "unix":
            opts = ["-std=c++17"]
        elif ct == "msvc":
            opts = ["/EHsc"]
        else:
            raise RuntimeError("Unsupported compiler: {}".format(ct))

        for ext in self.extensions:
            ext.extra_compile_args = opts
        build_ext.build_extensions(self)


setup(
    name="example",
    version=__version__,
    author="Your Name",
    author_email="your.email@example.com",
    url="https://github.com/yourusername/example",
    description="A test project using pybind11",
    long_description="",
    ext_modules=ext_modules,
    install_requires=["pybind11>=2.2"],
    cmdclass={"build_ext": BuildExt},
    zip_safe=False,
)
