#include "vendor/unity.h"

#include <stddef.h>
#include <stdint.h>

#define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))

extern ptrdiff_t find(int16_t value, int16_t *array, size_t count);

void setUp(void) {
}

void tearDown(void) {
}

void test_finds_a_value_in_an_array_with_one_element(void) {
    int16_t array[] = {6};
    TEST_ASSERT_EQUAL_INT(0, find(6, array, ARRAY_SIZE(array)));
}

void test_finds_a_value_in_the_middle_of_an_array(void) {
    TEST_IGNORE();
    int16_t array[] = {1, 3, 4, 6, 8, 9, 11};
    TEST_ASSERT_EQUAL_INT(3, find(6, array, ARRAY_SIZE(array)));
}

void test_finds_a_value_at_the_beginning_of_an_array(void) {
    TEST_IGNORE();
    int16_t array[] = {1, 3, 4, 6, 8, 9, 11};
    TEST_ASSERT_EQUAL_INT(0, find(1, array, ARRAY_SIZE(array)));
}

void test_finds_a_value_at_the_end_of_an_array(void) {
    TEST_IGNORE();
    int16_t array[] = {1, 3, 4, 6, 8, 9, 11};
    TEST_ASSERT_EQUAL_INT(6, find(11, array, ARRAY_SIZE(array)));
}

void test_finds_a_value_in_an_array_of_odd_length(void) {
    TEST_IGNORE();
    int16_t array[] = {1, 3, 5, 8, 13, 21, 34, 55, 89, 144, 233, 377, 634};
    TEST_ASSERT_EQUAL_INT(9, find(144, array, ARRAY_SIZE(array)));
}

void test_finds_a_value_in_an_array_of_even_length(void) {
    TEST_IGNORE();
    int16_t array[] = {1, 3, 5, 8, 13, 21, 34, 55, 89, 144, 233, 377};
    TEST_ASSERT_EQUAL_INT(5, find(21, array, ARRAY_SIZE(array)));
}

void test_identifies_that_a_value_is_not_included_in_the_array(void) {
    TEST_IGNORE();
    int16_t array[] = {1, 3, 4, 6, 8, 9, 11};
    TEST_ASSERT_EQUAL_INT(-1, find(7, array, ARRAY_SIZE(array)));
}

void test_a_value_smaller_than_the_arrays_smallest_value_is_not_found(void) {
    TEST_IGNORE();
    int16_t array[] = {1, 3, 4, 6, 8, 9, 11};
    TEST_ASSERT_EQUAL_INT(-1, find(0, array, ARRAY_SIZE(array)));
}

void test_a_value_larger_than_the_arrays_largest_value_is_not_found(void) {
    TEST_IGNORE();
    int16_t array[] = {1, 3, 4, 6, 8, 9, 11};
    TEST_ASSERT_EQUAL_INT(-1, find(13, array, ARRAY_SIZE(array)));
}

void test_nothing_is_found_in_an_empty_array(void) {
    TEST_IGNORE();
    TEST_ASSERT_EQUAL_INT(-1, find(1, NULL, 0));
}

void test_nothing_is_found_when_the_left_and_right_bounds_cross(void) {
    TEST_IGNORE();
    int16_t array[] = {1, 2};
    TEST_ASSERT_EQUAL_INT(-1, find(0, array, ARRAY_SIZE(array)));
}

void test_five_digits(void) {
    TEST_IGNORE();
    int16_t array[] = {11638, 18389, 21454, 29416, 32039};
    TEST_ASSERT_EQUAL_INT(2, find(21454, array, ARRAY_SIZE(array)));
}

int main(void) {
    UNITY_BEGIN();
    RUN_TEST(test_finds_a_value_in_an_array_with_one_element);
    RUN_TEST(test_finds_a_value_in_the_middle_of_an_array);
    RUN_TEST(test_finds_a_value_at_the_beginning_of_an_array);
    RUN_TEST(test_finds_a_value_at_the_end_of_an_array);
    RUN_TEST(test_finds_a_value_in_an_array_of_odd_length);
    RUN_TEST(test_finds_a_value_in_an_array_of_even_length);
    RUN_TEST(test_identifies_that_a_value_is_not_included_in_the_array);
    RUN_TEST(test_a_value_smaller_than_the_arrays_smallest_value_is_not_found);
    RUN_TEST(test_a_value_larger_than_the_arrays_largest_value_is_not_found);
    RUN_TEST(test_nothing_is_found_in_an_empty_array);
    RUN_TEST(test_nothing_is_found_when_the_left_and_right_bounds_cross);
    RUN_TEST(test_five_digits);
    return UNITY_END();
}
