#include "cppmult.h"

#define PY_SSIZE_T_CLEAN
#include <Python.h>

#include <iomanip>
#include <iostream>

float cppmult(int int_param, float float_param) {
  float return_value = static_cast<float>(int_param) * float_param;
  std::cout << std::setprecision(1) << std::fixed << "    In cppmul: int "
            << int_param << " float " << float_param << " returning  "
            << return_value << std::endl;
  return return_value;
}

// Only define this if build Python C Extension
#ifdef PY_EXTENSION

static PyObject* cppmult_impl(PyObject* self, PyObject* args) {
  int int_param;
  float float_param;
  if (!PyArg_ParseTuple(args, "if", &int_param, &float_param)) {
    return NULL;
  }
  float return_value = cppmult(int_param, float_param);
  return Py_BuildValue("f", return_value);
}

static PyMethodDef cppmult_methods[] = {
    {"cppmult", (PyCFunction)cppmult_impl, METH_VARARGS, NULL},
    // Terminate the array with an object containing nulls.
    {NULL, NULL, 0, NULL}};

static struct PyModuleDef cppmult_module = {
    PyModuleDef_HEAD_INIT,
    "cppmult",  // Module name to use with Python import statements
    "Provides some functions, but faster",  // Module description
    0,
    cppmult_methods  // Structure that defines the methods of the module
};

PyMODINIT_FUNC PyInit_cppmult() { return PyModule_Create(&cppmult_module); }

#endif

int main(int argc, char const* argv[]) {
#ifdef PY_EXTENSION
  std::cout << "Building Python C Extension" << std::endl;
#else
  std::cout << "Building C++ Executable" << std::endl;
  std::cout << "cppmult(2, 3.5) = " << cppmult(2, 3.5) << std::endl;
#endif

  return 0;
}
