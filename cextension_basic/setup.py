try:
    from setuptools import Extension, setup, find_packages
    from setuptools.command import build_ext
except ImportError:
    # distutils is a built-in library that comes with Python and provides basic functionality
    from distutils.command import build_ext
    from distutils.core import Extension, setup

    find_packages = lambda *args, **kwargs: []


ext_modules = [
    Extension(
        "cppmult",
        sources=["cppmult.cpp"],
        include_dirs=["."],
        define_macros=[("PY_EXTENSION", 1)],
        undef_macros=[],
        # compile for optimization
        extra_compile_args=[
            "-fPIC",  # position independent code: generate code can be loaded at any memory address
            "-O3",  # optimization level 3
            "-std=c++17",
            "-stdlib=libc++",
            "-Wall",  # enable all warnings
            "-Wno-unused-command-line-argument",
        ],
        # link for linking the libraries
        extra_link_args=[
            "-fPIC",  # position independent code: generate code can be loaded at any memory address
            "-O3",  # optimization level 3
            "-std=c++17",
            "-stdlib=libc++",
            "-Wall",  # enable all warnings
            "-Wno-unused-command-line-argument",
        ],
        library_dirs=[],
        libraries=[],
        extra_objects=[],
        language="c++",
    )
]

setup(
    packages=find_packages(),
    ext_modules=ext_modules,
)
