#include "cmult.h"

#include <iostream>

#include "gtest/gtest.h"

TEST(CmultTest, PositiveInts) { EXPECT_EQ(2, cmult(1, 2)); }

TEST(CmultTest, NegativeInts) { EXPECT_EQ(-2, cmult(-1, 2)); }

TEST(CmultTest, ZeroInts) { EXPECT_EQ(0, cmult(0, 2)); }

TEST(CmultVar, LongLongInt) { EXPECT_EQ(42, myint); }

TEST(CmultVar, DoubleFloat) { EXPECT_EQ(3.14, myfloat); }

TEST(Mytest, MayBirthday) {
  auto x = 8;
  auto y = 4;
  EXPECT_EQ(cmult(x, y), 32);
}

TEST(MyTest, HelloWorld) {
  std::string s1 = "Hello";
  std::string s2 = "World";
  s1 += s2;
  EXPECT_EQ(s1, "HelloWorld");
}

int main(int argc, char **argv) {
  ::testing::InitGoogleTest(&argc, argv);
  return RUN_ALL_TESTS();
}
