#include "vendor/unity.h"

#include <stdint.h>

extern uint64_t square(int64_t number);
extern uint64_t total(void);

void setUp(void) {
}

void tearDown(void) {
}

void test_grains_on_square_1(void) {
    TEST_ASSERT_EQUAL_UINT64(1U, square(1));
}

void test_grains_on_square_2(void) {
    TEST_IGNORE();
    TEST_ASSERT_EQUAL_UINT64(2U, square(2));
}

void test_grains_on_square_3(void) {
    TEST_IGNORE();
    TEST_ASSERT_EQUAL_UINT64(4U, square(3));
}

void test_grains_on_square_4(void) {
    TEST_IGNORE();
    TEST_ASSERT_EQUAL_UINT64(8U, square(4));
}

void test_grains_on_square_16(void) {
    TEST_IGNORE();
    TEST_ASSERT_EQUAL_UINT64(32768U, square(16));
}

void test_grains_on_square_32(void) {
    TEST_IGNORE();
    TEST_ASSERT_EQUAL_UINT64(2147483648U, square(32));
}

void test_grains_on_square_64(void) {
    TEST_IGNORE();
    TEST_ASSERT_EQUAL_UINT64(9223372036854775808U, square(64));
}

void test_square_0_is_invalid(void) {
    TEST_IGNORE();
    TEST_ASSERT_EQUAL_UINT64(0U, square(0));
}

void test_negative_square_is_invalid(void) {
    TEST_IGNORE();
    TEST_ASSERT_EQUAL_UINT64(0U, square(-1));
}

void test_square_greater_than_64_is_invalid(void) {
    TEST_IGNORE();
    TEST_ASSERT_EQUAL_UINT64(0U, square(65));
}

void test_returns_the_total_number_of_grains_on_the_board(void) {
    TEST_IGNORE();
    TEST_ASSERT_EQUAL_UINT64(18446744073709551615U, total());
}

int main(void) {
    UNITY_BEGIN();
    RUN_TEST(test_grains_on_square_1);
    RUN_TEST(test_grains_on_square_2);
    RUN_TEST(test_grains_on_square_3);
    RUN_TEST(test_grains_on_square_4);
    RUN_TEST(test_grains_on_square_16);
    RUN_TEST(test_grains_on_square_32);
    RUN_TEST(test_grains_on_square_64);
    RUN_TEST(test_square_0_is_invalid);
    RUN_TEST(test_negative_square_is_invalid);
    RUN_TEST(test_square_greater_than_64_is_invalid);
    RUN_TEST(test_returns_the_total_number_of_grains_on_the_board);
    return UNITY_END();
}
