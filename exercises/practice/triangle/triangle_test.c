#include "vendor/unity.h"

extern int equilateral(int a, int b, int c);
extern int isosceles(int a, int b, int c);
extern int scalene(int a, int b, int c);

void setUp(void) {
}

void tearDown(void) {
}

void test_equilateral_all_sides_are_equal(void) {
    TEST_ASSERT_TRUE(equilateral(2, 2, 2));
}

void test_equilateral_any_side_is_unequal(void) {
    TEST_IGNORE();
    TEST_ASSERT_FALSE(equilateral(2, 3, 2));
}

void test_equilateral_no_sides_are_equal(void) {
    TEST_IGNORE();
    TEST_ASSERT_FALSE(equilateral(5, 4, 6));
}

void test_equilateral_all_zero_sides_is_not_a_triangle(void) {
    TEST_IGNORE();
    TEST_ASSERT_FALSE(equilateral(0, 0, 0));
}

void test_isosceles_last_two_sides_are_equal(void) {
    TEST_IGNORE();
    TEST_ASSERT_TRUE(isosceles(3, 4, 4));
}

void test_isosceles_first_two_sides_are_equal(void) {
    TEST_IGNORE();
    TEST_ASSERT_TRUE(isosceles(4, 4, 3));
}

void test_isosceles_first_and_last_sides_are_equal(void) {
    TEST_IGNORE();
    TEST_ASSERT_TRUE(isosceles(4, 3, 4));
}

void test_isosceles_equilateral_triangles_are_also_isosceles(void) {
    TEST_IGNORE();
    TEST_ASSERT_TRUE(isosceles(4, 4, 4));
}

void test_isosceles_no_sides_are_equal(void) {
    TEST_IGNORE();
    TEST_ASSERT_FALSE(isosceles(2, 3, 4));
}

void test_isosceles_first_triangle_inequality_violation(void) {
    TEST_IGNORE();
    TEST_ASSERT_FALSE(isosceles(1, 1, 3));
}

void test_isosceles_second_triangle_inequality_violation(void) {
    TEST_IGNORE();
    TEST_ASSERT_FALSE(isosceles(1, 3, 1));
}

void test_isosceles_third_triangle_inequality_violation(void) {
    TEST_IGNORE();
    TEST_ASSERT_FALSE(isosceles(3, 1, 1));
}

void test_scalene_no_sides_are_equal(void) {
    TEST_IGNORE();
    TEST_ASSERT_TRUE(scalene(5, 4, 6));
}

void test_scalene_all_sides_are_equal(void) {
    TEST_IGNORE();
    TEST_ASSERT_FALSE(scalene(4, 4, 4));
}

void test_scalene_first_and_second_sides_are_equal(void) {
    TEST_IGNORE();
    TEST_ASSERT_FALSE(scalene(4, 4, 3));
}

void test_scalene_first_and_third_sides_are_equal(void) {
    TEST_IGNORE();
    TEST_ASSERT_FALSE(scalene(3, 4, 3));
}

void test_scalene_second_and_third_sides_are_equal(void) {
    TEST_IGNORE();
    TEST_ASSERT_FALSE(scalene(4, 3, 3));
}

void test_scalene_may_not_violate_triangle_inequality(void) {
    TEST_IGNORE();
    TEST_ASSERT_FALSE(scalene(7, 3, 2));
}

int main(void) {
    UNITY_BEGIN();
    RUN_TEST(test_equilateral_all_sides_are_equal);
    RUN_TEST(test_equilateral_any_side_is_unequal);
    RUN_TEST(test_equilateral_no_sides_are_equal);
    RUN_TEST(test_equilateral_all_zero_sides_is_not_a_triangle);
    RUN_TEST(test_isosceles_last_two_sides_are_equal);
    RUN_TEST(test_isosceles_first_two_sides_are_equal);
    RUN_TEST(test_isosceles_first_and_last_sides_are_equal);
    RUN_TEST(test_isosceles_equilateral_triangles_are_also_isosceles);
    RUN_TEST(test_isosceles_no_sides_are_equal);
    RUN_TEST(test_isosceles_first_triangle_inequality_violation);
    RUN_TEST(test_isosceles_second_triangle_inequality_violation);
    RUN_TEST(test_isosceles_third_triangle_inequality_violation);
    RUN_TEST(test_scalene_no_sides_are_equal);
    RUN_TEST(test_scalene_all_sides_are_equal);
    RUN_TEST(test_scalene_first_and_second_sides_are_equal);
    RUN_TEST(test_scalene_first_and_third_sides_are_equal);
    RUN_TEST(test_scalene_second_and_third_sides_are_equal);
    RUN_TEST(test_scalene_may_not_violate_triangle_inequality);
    return UNITY_END();
}
