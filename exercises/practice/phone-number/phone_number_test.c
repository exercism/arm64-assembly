#include "vendor/unity.h"

extern void clean(char *str);

void setUp(void) {
}

void tearDown(void) {
}

void test_cleans_the_number(void) {
    char str[] = "(223) 456-7890";
    clean(str);
    TEST_ASSERT_EQUAL_STRING("2234567890", str);
}

void test_cleans_numbers_with_dots(void) {
    TEST_IGNORE();
    char str[] = "223.456.7890";
    clean(str);
    TEST_ASSERT_EQUAL_STRING("2234567890", str);
}

void test_cleans_numbers_with_multiple_spaces(void) {
    TEST_IGNORE();
    char str[] = "223 456   7890   ";
    clean(str);
    TEST_ASSERT_EQUAL_STRING("2234567890", str);
}

void test_invalid_when_9_digits(void) {
    TEST_IGNORE();
    char str[] = "123456789";
    clean(str);
    TEST_ASSERT_EQUAL_STRING("", str);
}

void test_invalid_when_11_digits_does_not_start_with_a_1(void) {
    TEST_IGNORE();
    char str[] = "22234567890";
    clean(str);
    TEST_ASSERT_EQUAL_STRING("", str);
}

void test_valid_when_11_digits_and_starting_with_1(void) {
    TEST_IGNORE();
    char str[] = "12234567890";
    clean(str);
    TEST_ASSERT_EQUAL_STRING("2234567890", str);
}

void test_valid_when_11_digits_and_starting_with_1_even_with_punctuation(void) {
    TEST_IGNORE();
    char str[] = "+1 (223) 456-7890";
    clean(str);
    TEST_ASSERT_EQUAL_STRING("2234567890", str);
}

void test_invalid_when_more_than_11_digits(void) {
    TEST_IGNORE();
    char str[] = "321234567890";
    clean(str);
    TEST_ASSERT_EQUAL_STRING("", str);
}

void test_invalid_with_letters(void) {
    TEST_IGNORE();
    char str[] = "523-abc-7890";
    clean(str);
    TEST_ASSERT_EQUAL_STRING("", str);
}

void test_invalid_with_punctuations(void) {
    TEST_IGNORE();
    char str[] = "523-@:!-7890";
    clean(str);
    TEST_ASSERT_EQUAL_STRING("", str);
}

void test_invalid_if_area_code_starts_with_0(void) {
    TEST_IGNORE();
    char str[] = "(023) 456-7890";
    clean(str);
    TEST_ASSERT_EQUAL_STRING("", str);
}

void test_invalid_if_area_code_starts_with_1(void) {
    TEST_IGNORE();
    char str[] = "(123) 456-7890";
    clean(str);
    TEST_ASSERT_EQUAL_STRING("", str);
}

void test_invalid_if_exchange_code_starts_with_0(void) {
    TEST_IGNORE();
    char str[] = "(223) 056-7890";
    clean(str);
    TEST_ASSERT_EQUAL_STRING("", str);
}

void test_invalid_if_exchange_code_starts_with_1(void) {
    TEST_IGNORE();
    char str[] = "(223) 156-7890";
    clean(str);
    TEST_ASSERT_EQUAL_STRING("", str);
}

void test_invalid_if_area_code_starts_with_0_on_valid_11digit_number(void) {
    TEST_IGNORE();
    char str[] = "1 (023) 456-7890";
    clean(str);
    TEST_ASSERT_EQUAL_STRING("", str);
}

void test_invalid_if_area_code_starts_with_1_on_valid_11digit_number(void) {
    TEST_IGNORE();
    char str[] = "1 (123) 456-7890";
    clean(str);
    TEST_ASSERT_EQUAL_STRING("", str);
}

void test_invalid_if_exchange_code_starts_with_0_on_valid_11digit_number(void) {
    TEST_IGNORE();
    char str[] = "1 (223) 056-7890";
    clean(str);
    TEST_ASSERT_EQUAL_STRING("", str);
}

void test_invalid_if_exchange_code_starts_with_1_on_valid_11digit_number(void) {
    TEST_IGNORE();
    char str[] = "1 (223) 156-7890";
    clean(str);
    TEST_ASSERT_EQUAL_STRING("", str);
}

int main(void) {
    UNITY_BEGIN();
    RUN_TEST(test_cleans_the_number);
    RUN_TEST(test_cleans_numbers_with_dots);
    RUN_TEST(test_cleans_numbers_with_multiple_spaces);
    RUN_TEST(test_invalid_when_9_digits);
    RUN_TEST(test_invalid_when_11_digits_does_not_start_with_a_1);
    RUN_TEST(test_valid_when_11_digits_and_starting_with_1);
    RUN_TEST(test_valid_when_11_digits_and_starting_with_1_even_with_punctuation);
    RUN_TEST(test_invalid_when_more_than_11_digits);
    RUN_TEST(test_invalid_with_letters);
    RUN_TEST(test_invalid_with_punctuations);
    RUN_TEST(test_invalid_if_area_code_starts_with_0);
    RUN_TEST(test_invalid_if_area_code_starts_with_1);
    RUN_TEST(test_invalid_if_exchange_code_starts_with_0);
    RUN_TEST(test_invalid_if_exchange_code_starts_with_1);
    RUN_TEST(test_invalid_if_area_code_starts_with_0_on_valid_11digit_number);
    RUN_TEST(test_invalid_if_area_code_starts_with_1_on_valid_11digit_number);
    RUN_TEST(test_invalid_if_exchange_code_starts_with_0_on_valid_11digit_number);
    RUN_TEST(test_invalid_if_exchange_code_starts_with_1_on_valid_11digit_number);
    return UNITY_END();
}
