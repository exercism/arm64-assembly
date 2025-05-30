#include "vendor/unity.h"

#include <stddef.h>
#include <stdint.h>

#define MAX_ARRAY_SIZE 100
#define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))

extern size_t spiral_matrix(uint32_t *dest, size_t size);

void setUp(void) {
}

void tearDown(void) {
}

void test_empty_spiral(void) {
    uint32_t actual[MAX_ARRAY_SIZE];
    const size_t count = spiral_matrix(actual, 0);
    TEST_ASSERT_EQUAL_UINT(0U, count);
}

void test_trivial_spiral(void) {
    TEST_IGNORE();
    const uint32_t expected[] = {
        // clang-format off
        1,
        // clang-format on
    };
    uint32_t actual[MAX_ARRAY_SIZE];
    const size_t count = spiral_matrix(actual, 1);
    TEST_ASSERT_EQUAL_UINT(ARRAY_SIZE(expected), count);
    TEST_ASSERT_EQUAL_UINT32_ARRAY(expected, actual, count);
}

void test_spiral_of_size_2(void) {
    TEST_IGNORE();
    const uint32_t expected[] = {
        // clang-format off
        1, 2,
        4, 3,
        // clang-format on
    };
    uint32_t actual[MAX_ARRAY_SIZE];
    const size_t count = spiral_matrix(actual, 2);
    TEST_ASSERT_EQUAL_UINT(ARRAY_SIZE(expected), count);
    TEST_ASSERT_EQUAL_UINT32_ARRAY(expected, actual, count);
}

void test_spiral_of_size_3(void) {
    TEST_IGNORE();
    const uint32_t expected[] = {
        // clang-format off
        1, 2, 3,
        8, 9, 4,
        7, 6, 5,
        // clang-format on
    };
    uint32_t actual[MAX_ARRAY_SIZE];
    const size_t count = spiral_matrix(actual, 3);
    TEST_ASSERT_EQUAL_UINT(ARRAY_SIZE(expected), count);
    TEST_ASSERT_EQUAL_UINT32_ARRAY(expected, actual, count);
}

void test_spiral_of_size_4(void) {
    TEST_IGNORE();
    const uint32_t expected[] = {
        // clang-format off
        1, 2, 3, 4,
        12, 13, 14, 5,
        11, 16, 15, 6,
        10, 9, 8, 7,
        // clang-format on
    };
    uint32_t actual[MAX_ARRAY_SIZE];
    const size_t count = spiral_matrix(actual, 4);
    TEST_ASSERT_EQUAL_UINT(ARRAY_SIZE(expected), count);
    TEST_ASSERT_EQUAL_UINT32_ARRAY(expected, actual, count);
}

void test_spiral_of_size_5(void) {
    TEST_IGNORE();
    const uint32_t expected[] = {
        // clang-format off
        1, 2, 3, 4, 5,
        16, 17, 18, 19, 6,
        15, 24, 25, 20, 7,
        14, 23, 22, 21, 8,
        13, 12, 11, 10, 9,
        // clang-format on
    };
    uint32_t actual[MAX_ARRAY_SIZE];
    const size_t count = spiral_matrix(actual, 5);
    TEST_ASSERT_EQUAL_UINT(ARRAY_SIZE(expected), count);
    TEST_ASSERT_EQUAL_UINT32_ARRAY(expected, actual, count);
}

int main(void) {
    UNITY_BEGIN();
    RUN_TEST(test_empty_spiral);
    RUN_TEST(test_trivial_spiral);
    RUN_TEST(test_spiral_of_size_2);
    RUN_TEST(test_spiral_of_size_3);
    RUN_TEST(test_spiral_of_size_4);
    RUN_TEST(test_spiral_of_size_5);
    return UNITY_END();
}
