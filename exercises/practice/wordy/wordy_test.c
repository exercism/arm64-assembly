#include "vendor/unity.h"

#include <stdbool.h>
#include <stdint.h>

extern bool answer(int64_t *result, const char *question);

void setUp(void) {
}

void tearDown(void) {
}

void test_just_a_number(void) {
    int64_t result;
    const char *question = "What is 5?";
    TEST_ASSERT_TRUE(answer(&result, question));
    TEST_ASSERT_EQUAL_INT(5, result);
}

void test_addition(void) {
    TEST_IGNORE();
    int64_t result;
    const char *question = "What is 1 plus 1?";
    TEST_ASSERT_TRUE(answer(&result, question));
    TEST_ASSERT_EQUAL_INT(2, result);
}

void test_more_addition(void) {
    TEST_IGNORE();
    int64_t result;
    const char *question = "What is 53 plus 2?";
    TEST_ASSERT_TRUE(answer(&result, question));
    TEST_ASSERT_EQUAL_INT(55, result);
}

void test_addition_with_negative_numbers(void) {
    TEST_IGNORE();
    int64_t result;
    const char *question = "What is -1 plus -10?";
    TEST_ASSERT_TRUE(answer(&result, question));
    TEST_ASSERT_EQUAL_INT(-11, result);
}

void test_large_addition(void) {
    TEST_IGNORE();
    int64_t result;
    const char *question = "What is 123 plus 45678?";
    TEST_ASSERT_TRUE(answer(&result, question));
    TEST_ASSERT_EQUAL_INT(45801, result);
}

void test_subtraction(void) {
    TEST_IGNORE();
    int64_t result;
    const char *question = "What is 4 minus -12?";
    TEST_ASSERT_TRUE(answer(&result, question));
    TEST_ASSERT_EQUAL_INT(16, result);
}

void test_multiplication(void) {
    TEST_IGNORE();
    int64_t result;
    const char *question = "What is -3 multiplied by 25?";
    TEST_ASSERT_TRUE(answer(&result, question));
    TEST_ASSERT_EQUAL_INT(-75, result);
}

void test_division(void) {
    TEST_IGNORE();
    int64_t result;
    const char *question = "What is 33 divided by -3?";
    TEST_ASSERT_TRUE(answer(&result, question));
    TEST_ASSERT_EQUAL_INT(-11, result);
}

void test_multiple_additions(void) {
    TEST_IGNORE();
    int64_t result;
    const char *question = "What is 1 plus 1 plus 1?";
    TEST_ASSERT_TRUE(answer(&result, question));
    TEST_ASSERT_EQUAL_INT(3, result);
}

void test_addition_and_subtraction(void) {
    TEST_IGNORE();
    int64_t result;
    const char *question = "What is 1 plus 5 minus -2?";
    TEST_ASSERT_TRUE(answer(&result, question));
    TEST_ASSERT_EQUAL_INT(8, result);
}

void test_multiple_subtraction(void) {
    TEST_IGNORE();
    int64_t result;
    const char *question = "What is 20 minus 4 minus 13?";
    TEST_ASSERT_TRUE(answer(&result, question));
    TEST_ASSERT_EQUAL_INT(3, result);
}

void test_subtraction_then_addition(void) {
    TEST_IGNORE();
    int64_t result;
    const char *question = "What is 17 minus 6 plus 3?";
    TEST_ASSERT_TRUE(answer(&result, question));
    TEST_ASSERT_EQUAL_INT(14, result);
}

void test_multiple_multiplication(void) {
    TEST_IGNORE();
    int64_t result;
    const char *question = "What is 2 multiplied by -2 multiplied by 3?";
    TEST_ASSERT_TRUE(answer(&result, question));
    TEST_ASSERT_EQUAL_INT(-12, result);
}

void test_addition_and_multiplication(void) {
    TEST_IGNORE();
    int64_t result;
    const char *question = "What is -3 plus 7 multiplied by -2?";
    TEST_ASSERT_TRUE(answer(&result, question));
    TEST_ASSERT_EQUAL_INT(-8, result);
}

void test_multiple_division(void) {
    TEST_IGNORE();
    int64_t result;
    const char *question = "What is -12 divided by 2 divided by -3?";
    TEST_ASSERT_TRUE(answer(&result, question));
    TEST_ASSERT_EQUAL_INT(2, result);
}

void test_unknown_operation(void) {
    TEST_IGNORE();
    int64_t result;
    const char *question = "What is 52 cubed?";
    TEST_ASSERT_FALSE(answer(&result, question));
}

void test_non_math_question(void) {
    TEST_IGNORE();
    int64_t result;
    const char *question = "Who is the President of the United States?";
    TEST_ASSERT_FALSE(answer(&result, question));
}

void test_reject_problem_missing_an_operand(void) {
    TEST_IGNORE();
    int64_t result;
    const char *question = "What is 1 plus?";
    TEST_ASSERT_FALSE(answer(&result, question));
}

void test_reject_problem_with_no_operands_or_operators(void) {
    TEST_IGNORE();
    int64_t result;
    const char *question = "What is?";
    TEST_ASSERT_FALSE(answer(&result, question));
}

void test_reject_two_operations_in_a_row(void) {
    TEST_IGNORE();
    int64_t result;
    const char *question = "What is 1 plus plus 2?";
    TEST_ASSERT_FALSE(answer(&result, question));
}

void test_reject_two_numbers_in_a_row(void) {
    TEST_IGNORE();
    int64_t result;
    const char *question = "What is 1 plus 2 1?";
    TEST_ASSERT_FALSE(answer(&result, question));
}

void test_reject_postfix_notation(void) {
    TEST_IGNORE();
    int64_t result;
    const char *question = "What is 1 2 plus?";
    TEST_ASSERT_FALSE(answer(&result, question));
}

void test_reject_prefix_notation(void) {
    TEST_IGNORE();
    int64_t result;
    const char *question = "What is plus 1 2?";
    TEST_ASSERT_FALSE(answer(&result, question));
}

int main(void) {
    UNITY_BEGIN();
    RUN_TEST(test_just_a_number);
    RUN_TEST(test_addition);
    RUN_TEST(test_more_addition);
    RUN_TEST(test_addition_with_negative_numbers);
    RUN_TEST(test_large_addition);
    RUN_TEST(test_subtraction);
    RUN_TEST(test_multiplication);
    RUN_TEST(test_division);
    RUN_TEST(test_multiple_additions);
    RUN_TEST(test_addition_and_subtraction);
    RUN_TEST(test_multiple_subtraction);
    RUN_TEST(test_subtraction_then_addition);
    RUN_TEST(test_multiple_multiplication);
    RUN_TEST(test_addition_and_multiplication);
    RUN_TEST(test_multiple_division);
    RUN_TEST(test_unknown_operation);
    RUN_TEST(test_non_math_question);
    RUN_TEST(test_reject_problem_missing_an_operand);
    RUN_TEST(test_reject_problem_with_no_operands_or_operators);
    RUN_TEST(test_reject_two_operations_in_a_row);
    RUN_TEST(test_reject_two_numbers_in_a_row);
    RUN_TEST(test_reject_postfix_notation);
    RUN_TEST(test_reject_prefix_notation);
    return UNITY_END();
}
