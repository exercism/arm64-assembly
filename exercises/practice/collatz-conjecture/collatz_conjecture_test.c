#include "vendor/unity.h"

#include <stdint.h>

#define INVALID_NUMBER -1

extern int steps(int64_t number);

void setUp(void) {
}

void tearDown(void) {
}

void test_zero_steps_for_one(void) {
    TEST_ASSERT_EQUAL_INT(0, steps(1));
}

void test_divide_if_even(void) {
    TEST_IGNORE();
    TEST_ASSERT_EQUAL_INT(4, steps(16));
}

void test_even_and_odd_steps(void) {
    TEST_IGNORE();
    TEST_ASSERT_EQUAL_INT(9, steps(12));
}

void test_large_number_of_even_and_odd_steps(void) {
    TEST_IGNORE();
    TEST_ASSERT_EQUAL_INT(152, steps(1000000));
}

void test_zero_is_an_error(void) {
    TEST_IGNORE();
    TEST_ASSERT_EQUAL_INT(INVALID_NUMBER, steps(0));
}

void test_negative_value_is_an_error(void) {
    TEST_IGNORE();
    TEST_ASSERT_EQUAL_INT(INVALID_NUMBER, steps(-15));
}

void test_large_positive(void) {
    TEST_IGNORE();
    TEST_ASSERT_EQUAL_INT(817, steps(2037066081));
}

void test_large_negative(void) {
    TEST_IGNORE();
    TEST_ASSERT_EQUAL_INT(INVALID_NUMBER, steps(-7001002003));
}

int main(void) {
    UNITY_BEGIN();
    RUN_TEST(test_zero_steps_for_one);
    RUN_TEST(test_divide_if_even);
    RUN_TEST(test_even_and_odd_steps);
    RUN_TEST(test_large_number_of_even_and_odd_steps);
    RUN_TEST(test_zero_is_an_error);
    RUN_TEST(test_negative_value_is_an_error);
    RUN_TEST(test_large_positive);
    RUN_TEST(test_large_negative);
    return UNITY_END();
}
