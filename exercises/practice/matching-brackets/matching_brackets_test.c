#include "vendor/unity.h"

extern int is_paired(const char *value);

void setUp(void) {
}

void tearDown(void) {
}

void test_paired_square_brackets(void) {
    TEST_ASSERT_TRUE(is_paired("[]"));
}

void test_empty_string(void) {
    TEST_IGNORE();
    TEST_ASSERT_TRUE(is_paired(""));
}

void test_unpaired_brackets(void) {
    TEST_IGNORE();
    TEST_ASSERT_FALSE(is_paired("[["));
}

void test_wrong_ordered_brackets(void) {
    TEST_IGNORE();
    TEST_ASSERT_FALSE(is_paired("}{"));
}

void test_wrong_closing_bracket(void) {
    TEST_IGNORE();
    TEST_ASSERT_FALSE(is_paired("{]"));
}

void test_paired_with_whitespace(void) {
    TEST_IGNORE();
    TEST_ASSERT_TRUE(is_paired("{ }"));
}

void test_partially_paired_brackets(void) {
    TEST_IGNORE();
    TEST_ASSERT_FALSE(is_paired("{[])"));
}

void test_simple_nested_brackets(void) {
    TEST_IGNORE();
    TEST_ASSERT_TRUE(is_paired("{[]}"));
}

void test_several_paired_brackets(void) {
    TEST_IGNORE();
    TEST_ASSERT_TRUE(is_paired("{}[]"));
}

void test_paired_and_nested_brackets(void) {
    TEST_IGNORE();
    TEST_ASSERT_TRUE(is_paired("([{}({}[])])"));
}

void test_unopened_closing_brackets(void) {
    TEST_IGNORE();
    TEST_ASSERT_FALSE(is_paired("{[)][]}"));
}

void test_unpaired_and_nested_brackets(void) {
    TEST_IGNORE();
    TEST_ASSERT_FALSE(is_paired("([{])"));
}

void test_paired_and_wrong_nested_brackets(void) {
    TEST_IGNORE();
    TEST_ASSERT_FALSE(is_paired("[({]})"));
}

void test_paired_and_wrong_nested_brackets_but_innermost_are_correct(void) {
    TEST_IGNORE();
    TEST_ASSERT_FALSE(is_paired("[({}])"));
}

void test_paired_and_incomplete_brackets(void) {
    TEST_IGNORE();
    TEST_ASSERT_FALSE(is_paired("{}["));
}

void test_too_many_closing_brackets(void) {
    TEST_IGNORE();
    TEST_ASSERT_FALSE(is_paired("[]]"));
}

void test_early_unexpected_brackets(void) {
    TEST_IGNORE();
    TEST_ASSERT_FALSE(is_paired(")()"));
}

void test_early_mismatched_brackets(void) {
    TEST_IGNORE();
    TEST_ASSERT_FALSE(is_paired("{)()"));
}

void test_math_expression(void) {
    TEST_IGNORE();
    TEST_ASSERT_TRUE(is_paired("(((185 + 223.85) * 15) - 543)/2"));
}

void test_complex_latex_expression(void) {
    TEST_IGNORE();
    TEST_ASSERT_TRUE(is_paired("\\left(\\begin{array}{cc} \\frac{1}{3} & x\\\\ \\mathrm{e}^{x} &... x^2 \\end{array}\\right)"));
}

int main(void) {
    UNITY_BEGIN();
    RUN_TEST(test_paired_square_brackets);
    RUN_TEST(test_empty_string);
    RUN_TEST(test_unpaired_brackets);
    RUN_TEST(test_wrong_ordered_brackets);
    RUN_TEST(test_wrong_closing_bracket);
    RUN_TEST(test_paired_with_whitespace);
    RUN_TEST(test_partially_paired_brackets);
    RUN_TEST(test_simple_nested_brackets);
    RUN_TEST(test_several_paired_brackets);
    RUN_TEST(test_paired_and_nested_brackets);
    RUN_TEST(test_unopened_closing_brackets);
    RUN_TEST(test_unpaired_and_nested_brackets);
    RUN_TEST(test_paired_and_wrong_nested_brackets);
    RUN_TEST(test_paired_and_wrong_nested_brackets_but_innermost_are_correct);
    RUN_TEST(test_paired_and_incomplete_brackets);
    RUN_TEST(test_too_many_closing_brackets);
    RUN_TEST(test_early_unexpected_brackets);
    RUN_TEST(test_early_mismatched_brackets);
    RUN_TEST(test_math_expression);
    RUN_TEST(test_complex_latex_expression);
    return UNITY_END();
}
