#include "vendor/unity.h"

extern int is_armstrong_number(unsigned number);

void setUp(void) {
}

void tearDown(void) {
}

void test_zero_is_an_armstrong_number(void) {
    TEST_ASSERT_TRUE(is_armstrong_number(0));
}

void test_singledigit_numbers_are_armstrong_numbers(void) {
    TEST_IGNORE();
    TEST_ASSERT_TRUE(is_armstrong_number(5));
}

void test_there_are_no_twodigit_armstrong_numbers(void) {
    TEST_IGNORE();
    TEST_ASSERT_FALSE(is_armstrong_number(10));
}

void test_threedigit_number_that_is_an_armstrong_number(void) {
    TEST_IGNORE();
    TEST_ASSERT_TRUE(is_armstrong_number(153));
}

void test_threedigit_number_that_is_not_an_armstrong_number(void) {
    TEST_IGNORE();
    TEST_ASSERT_FALSE(is_armstrong_number(100));
}

void test_fourdigit_number_that_is_an_armstrong_number(void) {
    TEST_IGNORE();
    TEST_ASSERT_TRUE(is_armstrong_number(9474));
}

void test_fourdigit_number_that_is_not_an_armstrong_number(void) {
    TEST_IGNORE();
    TEST_ASSERT_FALSE(is_armstrong_number(9475));
}

void test_sevendigit_number_that_is_an_armstrong_number(void) {
    TEST_IGNORE();
    TEST_ASSERT_TRUE(is_armstrong_number(9926315));
}

void test_sevendigit_number_that_is_not_an_armstrong_number(void) {
    TEST_IGNORE();
    TEST_ASSERT_FALSE(is_armstrong_number(9926314));
}

int main(void) {
    UNITY_BEGIN();
    RUN_TEST(test_zero_is_an_armstrong_number);
    RUN_TEST(test_singledigit_numbers_are_armstrong_numbers);
    RUN_TEST(test_there_are_no_twodigit_armstrong_numbers);
    RUN_TEST(test_threedigit_number_that_is_an_armstrong_number);
    RUN_TEST(test_threedigit_number_that_is_not_an_armstrong_number);
    RUN_TEST(test_fourdigit_number_that_is_an_armstrong_number);
    RUN_TEST(test_fourdigit_number_that_is_not_an_armstrong_number);
    RUN_TEST(test_sevendigit_number_that_is_an_armstrong_number);
    RUN_TEST(test_sevendigit_number_that_is_not_an_armstrong_number);
    return UNITY_END();
}
