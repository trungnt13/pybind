#include "cmult.h"

#include <stdio.h>

double myfloat = 3.14;
long long myint = 42;

float cmult(int x, float y) {
  // convert x to float
  // then multiply
  float result = static_cast<float>(x) * y;
  printf("In C++: int %d * float %f = float %f\n", x, y, result);
  return result;
}
