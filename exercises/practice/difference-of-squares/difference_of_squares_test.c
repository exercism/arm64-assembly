#include "vendor/unity.h"

#include <stdint.h>

extern uint64_t square_of_sum(uint64_t number);
extern uint64_t sum_of_squares(uint64_t number);
extern uint64_t difference_of_squares(uint64_t number);

void setUp(void) {
}

void tearDown(void) {
}

void test_square_of_sum_1(void) {
    TEST_ASSERT_EQUAL_UINT64(1U, square_of_sum(1));
}

void test_square_of_sum_5(void) {
    TEST_IGNORE();
    TEST_ASSERT_EQUAL_UINT64(225U, square_of_sum(5));
}

void test_square_of_sum_100(void) {
    TEST_IGNORE();
    TEST_ASSERT_EQUAL_UINT64(25502500U, square_of_sum(100));
}

void test_sum_of_squares_1(void) {
    TEST_IGNORE();
    TEST_ASSERT_EQUAL_UINT64(1U, sum_of_squares(1));
}

void test_sum_of_squares_5(void) {
    TEST_IGNORE();
    TEST_ASSERT_EQUAL_UINT64(55U, sum_of_squares(5));
}

void test_sum_of_squares_100(void) {
    TEST_IGNORE();
    TEST_ASSERT_EQUAL_UINT64(338350U, sum_of_squares(100));
}

void test_difference_of_squares_1(void) {
    TEST_IGNORE();
    TEST_ASSERT_EQUAL_UINT64(0U, difference_of_squares(1));
}

void test_difference_of_squares_5(void) {
    TEST_IGNORE();
    TEST_ASSERT_EQUAL_UINT64(170U, difference_of_squares(5));
}

void test_difference_of_squares_100(void) {
    TEST_IGNORE();
    TEST_ASSERT_EQUAL_UINT64(25164150U, difference_of_squares(100));
}

void test_square_of_sum_90000(void) {
    TEST_IGNORE();
    TEST_ASSERT_EQUAL_UINT64(16402864502025000000U, square_of_sum(90000));
}

void test_sum_of_squares_90000(void) {
    TEST_IGNORE();
    TEST_ASSERT_EQUAL_UINT64(243004050015000U, sum_of_squares(90000));
}

void test_difference_of_squares_90000(void) {
    TEST_IGNORE();
    TEST_ASSERT_EQUAL_UINT64(16402621497974985000U, difference_of_squares(90000));
}

int main(void) {
    UNITY_BEGIN();
    RUN_TEST(test_square_of_sum_1);
    RUN_TEST(test_square_of_sum_5);
    RUN_TEST(test_square_of_sum_100);
    RUN_TEST(test_sum_of_squares_1);
    RUN_TEST(test_sum_of_squares_5);
    RUN_TEST(test_sum_of_squares_100);
    RUN_TEST(test_difference_of_squares_1);
    RUN_TEST(test_difference_of_squares_5);
    RUN_TEST(test_difference_of_squares_100);
    RUN_TEST(test_square_of_sum_90000);
    RUN_TEST(test_sum_of_squares_90000);
    RUN_TEST(test_difference_of_squares_90000);
    return UNITY_END();
}
