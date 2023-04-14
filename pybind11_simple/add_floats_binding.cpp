#include <pybind11/pybind11.h>
#include "add_floats.h"

namespace py = pybind11;

PYBIND11_MODULE(add_floats_py, m) {
    m.doc() = "Add two floats using C++";
    m.def("add", &add, "Add two floats");
}
