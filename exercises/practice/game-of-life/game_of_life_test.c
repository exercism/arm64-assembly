#include "vendor/unity.h"

#include <stddef.h>
#include <stdint.h>

extern void tick(uint64_t *buffer, const uint64_t *matrix, size_t row_count, size_t column_count);

void setUp(void) {
}

void tearDown(void) {
}

void test_live_cells_with_zero_live_neighbors_die(void) {
    uint64_t actual[3];
    const uint64_t matrix[] = {
        // clang-format off
        0x0,
        0x2,
        0x0,
        // clang-format on
    };
    const uint64_t expected[] = {
        // clang-format off
        0x0,
        0x0,
        0x0,
        // clang-format on
    };
    tick(actual, matrix, 3, 3);
    TEST_ASSERT_EQUAL_UINT64_ARRAY(expected, actual, 3);
}

void test_live_cells_with_only_one_live_neighbor_die(void) {
    TEST_IGNORE();
    uint64_t actual[3];
    const uint64_t matrix[] = {
        // clang-format off
        0x0,
        0x2,
        0x2,
        // clang-format on
    };
    const uint64_t expected[] = {
        // clang-format off
        0x0,
        0x0,
        0x0,
        // clang-format on
    };
    tick(actual, matrix, 3, 3);
    TEST_ASSERT_EQUAL_UINT64_ARRAY(expected, actual, 3);
}

void test_live_cells_with_two_live_neighbors_stay_alive(void) {
    TEST_IGNORE();
    uint64_t actual[3];
    const uint64_t matrix[] = {
        // clang-format off
        0x5,
        0x5,
        0x5,
        // clang-format on
    };
    const uint64_t expected[] = {
        // clang-format off
        0x0,
        0x5,
        0x0,
        // clang-format on
    };
    tick(actual, matrix, 3, 3);
    TEST_ASSERT_EQUAL_UINT64_ARRAY(expected, actual, 3);
}

void test_live_cells_with_three_live_neighbors_stay_alive(void) {
    TEST_IGNORE();
    uint64_t actual[3];
    const uint64_t matrix[] = {
        // clang-format off
        0x2,
        0x4,
        0x6,
        // clang-format on
    };
    const uint64_t expected[] = {
        // clang-format off
        0x0,
        0x4,
        0x6,
        // clang-format on
    };
    tick(actual, matrix, 3, 3);
    TEST_ASSERT_EQUAL_UINT64_ARRAY(expected, actual, 3);
}

void test_dead_cells_with_three_live_neighbors_become_alive(void) {
    TEST_IGNORE();
    uint64_t actual[3];
    const uint64_t matrix[] = {
        // clang-format off
        0x6,
        0x0,
        0x4,
        // clang-format on
    };
    const uint64_t expected[] = {
        // clang-format off
        0x0,
        0x6,
        0x0,
        // clang-format on
    };
    tick(actual, matrix, 3, 3);
    TEST_ASSERT_EQUAL_UINT64_ARRAY(expected, actual, 3);
}

void test_live_cells_with_four_or_more_neighbors_die(void) {
    TEST_IGNORE();
    uint64_t actual[3];
    const uint64_t matrix[] = {
        // clang-format off
        0x7,
        0x7,
        0x7,
        // clang-format on
    };
    const uint64_t expected[] = {
        // clang-format off
        0x5,
        0x0,
        0x5,
        // clang-format on
    };
    tick(actual, matrix, 3, 3);
    TEST_ASSERT_EQUAL_UINT64_ARRAY(expected, actual, 3);
}

void test_bigger_matrix(void) {
    TEST_IGNORE();
    uint64_t actual[8];
    const uint64_t matrix[] = {
        // clang-format off
        0xd8,
        0xb0,
        0xe7,
        0x6,
        0x8c,
        0xc7,
        0x29,
        0x83,
        // clang-format on
    };
    const uint64_t expected[] = {
        // clang-format off
        0xd8,
        0x6,
        0xbd,
        0x81,
        0xc9,
        0xd1,
        0x80,
        0x3,
        // clang-format on
    };
    tick(actual, matrix, 8, 8);
    TEST_ASSERT_EQUAL_UINT64_ARRAY(expected, actual, 8);
}

void test_matrix_with_0_columns(void) {
    TEST_IGNORE();
    uint64_t actual[5];
    const uint64_t matrix[] = {
        // clang-format off
        0x0,
        0x0,
        0x0,
        0x0,
        0x0,
        // clang-format on
    };
    const uint64_t expected[] = {
        // clang-format off
        0x0,
        0x0,
        0x0,
        0x0,
        0x0,
        // clang-format on
    };
    tick(actual, matrix, 5, 0);
    TEST_ASSERT_EQUAL_UINT64_ARRAY(expected, actual, 5);
}

void test_matrix_with_32_columns(void) {
    TEST_IGNORE();
    uint64_t actual[5];
    const uint64_t matrix[] = {
        // clang-format off
        0xec6efb48,
        0xbeb23898,
        0xed06beb6,
        0x91205a96,
        0x93710c2c,
        // clang-format on
    };
    const uint64_t expected[] = {
        // clang-format off
        0xa26f4d98,
        0x1b08080,
        0x81f702a2,
        0x9573c200,
        0x3f01c1e,
        // clang-format on
    };
    tick(actual, matrix, 5, 32);
    TEST_ASSERT_EQUAL_UINT64_ARRAY(expected, actual, 5);
}

void test_matrix_with_64_columns(void) {
    TEST_IGNORE();
    uint64_t actual[5];
    const uint64_t matrix[] = {
        // clang-format off
        0xe1a9452f9072d77a,
        0x25150d7d533f22c,
        0x9c20fdcb0fadc212,
        0x55941c3f54993610,
        0x3ddd9f17d265087a,
        // clang-format on
    };
    const uint64_t expected[] = {
        // clang-format off
        0x41f020f868521f68,
        0xbfd1141075001842,
        0x35f8c70050a40b34,
        0x4117006050817e04,
        0x35761230487a1c38,
        // clang-format on
    };
    tick(actual, matrix, 5, 64);
    TEST_ASSERT_EQUAL_UINT64_ARRAY(expected, actual, 5);
}

int main(void) {
    UNITY_BEGIN();
    RUN_TEST(test_live_cells_with_zero_live_neighbors_die);
    RUN_TEST(test_live_cells_with_only_one_live_neighbor_die);
    RUN_TEST(test_live_cells_with_two_live_neighbors_stay_alive);
    RUN_TEST(test_live_cells_with_three_live_neighbors_stay_alive);
    RUN_TEST(test_dead_cells_with_three_live_neighbors_become_alive);
    RUN_TEST(test_live_cells_with_four_or_more_neighbors_die);
    RUN_TEST(test_bigger_matrix);
    RUN_TEST(test_matrix_with_0_columns);
    RUN_TEST(test_matrix_with_32_columns);
    RUN_TEST(test_matrix_with_64_columns);
    return UNITY_END();
}
