#include <gtest/gtest.h>

#include "mult_floats.h"

TEST(MultFloatsTest, PositiveNumbers) {
  float x = 3.0f;
  float y = 4.0f;
  float expected_result = 12.0f;
  EXPECT_FLOAT_EQ(mult_floats(x, y), expected_result);
}

TEST(MultFloatsTest, NegativeNumbers) {
  float x = -3.0f;
  float y = -4.0f;
  float expected_result = 12.0f;
  EXPECT_FLOAT_EQ(mult_floats(x, y), expected_result);
}

int mult_tests(int argc, char **argv) {
  ::testing::InitGoogleTest(&argc, argv);
  return RUN_ALL_TESTS();
}
