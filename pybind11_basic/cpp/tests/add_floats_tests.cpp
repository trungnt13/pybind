#include <gtest/gtest.h>

#include "add_floats.h"

TEST(AddFloatsTest, PositiveNumbers) {
  float x = 3.0f;
  float y = 4.0f;
  float expected_result = 7.0f;
  EXPECT_FLOAT_EQ(add_floats(x, y), expected_result);
}

TEST(AddFloatsTest, NegativeNumbers) {
  float x = -3.0f;
  float y = -4.0f;
  float expected_result = -7.0f;
  EXPECT_FLOAT_EQ(add_floats(x, y), expected_result);
}

TEST(AddFloatsTest, MixedNumbers) {
  float x = 3.0f;
  float y = -4.0f;
  float expected_result = -1.0f;
  EXPECT_FLOAT_EQ(add_floats(x, y), expected_result);
}

int add_tests(int argc, char **argv) {
  ::testing::InitGoogleTest(&argc, argv);
  return RUN_ALL_TESTS();
}
