#include "vendor/unity.h"

extern int score(double x, double y);

void setUp(void) {
}

void tearDown(void) {
}

void test_missed_target(void) {
    TEST_ASSERT_EQUAL_INT(0, score(-9, 9));
}

void test_on_the_outer_circle(void) {
    TEST_IGNORE();
    TEST_ASSERT_EQUAL_INT(1, score(0, 10));
}

void test_on_the_middle_circle(void) {
    TEST_IGNORE();
    TEST_ASSERT_EQUAL_INT(5, score(-5, 0));
}

void test_on_the_inner_circle(void) {
    TEST_IGNORE();
    TEST_ASSERT_EQUAL_INT(10, score(0, -1));
}

void test_exactly_on_center(void) {
    TEST_IGNORE();
    TEST_ASSERT_EQUAL_INT(10, score(0, 0));
}

void test_near_the_center(void) {
    TEST_IGNORE();
    TEST_ASSERT_EQUAL_INT(10, score(-0.1, -0.1));
}

void test_just_within_the_inner_circle(void) {
    TEST_IGNORE();
    TEST_ASSERT_EQUAL_INT(10, score(0.7, 0.7));
}

void test_just_outside_the_inner_circle(void) {
    TEST_IGNORE();
    TEST_ASSERT_EQUAL_INT(5, score(0.8, -0.8));
}

void test_just_within_the_middle_circle(void) {
    TEST_IGNORE();
    TEST_ASSERT_EQUAL_INT(5, score(-3.5, 3.5));
}

void test_just_outside_the_middle_circle(void) {
    TEST_IGNORE();
    TEST_ASSERT_EQUAL_INT(1, score(-3.6, -3.6));
}

void test_just_within_the_outer_circle(void) {
    TEST_IGNORE();
    TEST_ASSERT_EQUAL_INT(1, score(-7.0, 7.0));
}

void test_just_outside_the_outer_circle(void) {
    TEST_IGNORE();
    TEST_ASSERT_EQUAL_INT(0, score(7.1, -7.1));
}

void test_asymmetric_position_between_the_inner_and_middle_circles(void) {
    TEST_IGNORE();
    TEST_ASSERT_EQUAL_INT(5, score(0.5, -4));
}

int main(void) {
    UNITY_BEGIN();
    RUN_TEST(test_missed_target);
    RUN_TEST(test_on_the_outer_circle);
    RUN_TEST(test_on_the_middle_circle);
    RUN_TEST(test_on_the_inner_circle);
    RUN_TEST(test_exactly_on_center);
    RUN_TEST(test_near_the_center);
    RUN_TEST(test_just_within_the_inner_circle);
    RUN_TEST(test_just_outside_the_inner_circle);
    RUN_TEST(test_just_within_the_middle_circle);
    RUN_TEST(test_just_outside_the_middle_circle);
    RUN_TEST(test_just_within_the_outer_circle);
    RUN_TEST(test_just_outside_the_outer_circle);
    RUN_TEST(test_asymmetric_position_between_the_inner_and_middle_circles);
    return UNITY_END();
}
