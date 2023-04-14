#include <pybind11/pybind11.h>

#include "add_floats.h"
#include "mult_floats.h"

#ifndef MODULE_NAME
#define MODULE_NAME arith
#endif  // MODULE_NAME

namespace py = pybind11;

PYBIND11_MODULE(MODULE_NAME, m) {
  m.doc() = "pybind11 arithmetic plugin";  // optional module docstring

  m.def("add_floats", &add_floats, "A function which adds two floats");
  m.def("mult_floats", &mult_floats, "A function which multiplies two floats");
}
