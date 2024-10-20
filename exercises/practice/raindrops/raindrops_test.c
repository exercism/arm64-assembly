#include "vendor/unity.h"

#include <stdint.h>

#define BUFFER_SIZE 16

extern void convert(char *buffer, uint64_t number);

void setUp(void) {
}

void tearDown(void) {
}

void test_the_sound_for_1_is_1(void) {
    char buffer[BUFFER_SIZE];

    convert(buffer, 1);
    TEST_ASSERT_EQUAL_STRING("1", buffer);
}

void test_the_sound_for_3_is_pling(void) {
    TEST_IGNORE();
    char buffer[BUFFER_SIZE];

    convert(buffer, 3);
    TEST_ASSERT_EQUAL_STRING("Pling", buffer);
}

void test_the_sound_for_5_is_plang(void) {
    TEST_IGNORE();
    char buffer[BUFFER_SIZE];

    convert(buffer, 5);
    TEST_ASSERT_EQUAL_STRING("Plang", buffer);
}

void test_the_sound_for_7_is_plong(void) {
    TEST_IGNORE();
    char buffer[BUFFER_SIZE];

    convert(buffer, 7);
    TEST_ASSERT_EQUAL_STRING("Plong", buffer);
}

void test_the_sound_for_6_is_pling_as_it_has_a_factor_3(void) {
    TEST_IGNORE();
    char buffer[BUFFER_SIZE];

    convert(buffer, 6);
    TEST_ASSERT_EQUAL_STRING("Pling", buffer);
}

void test_2_to_the_power_3_does_not_make_a_raindrop_sound_as_3_is_the_exponent_not_the_base(void) {
    TEST_IGNORE();
    char buffer[BUFFER_SIZE];

    convert(buffer, 8);
    TEST_ASSERT_EQUAL_STRING("8", buffer);
}

void test_the_sound_for_9_is_pling_as_it_has_a_factor_3(void) {
    TEST_IGNORE();
    char buffer[BUFFER_SIZE];

    convert(buffer, 9);
    TEST_ASSERT_EQUAL_STRING("Pling", buffer);
}

void test_the_sound_for_10_is_plang_as_it_has_a_factor_5(void) {
    TEST_IGNORE();
    char buffer[BUFFER_SIZE];

    convert(buffer, 10);
    TEST_ASSERT_EQUAL_STRING("Plang", buffer);
}

void test_the_sound_for_14_is_plong_as_it_has_a_factor_of_7(void) {
    TEST_IGNORE();
    char buffer[BUFFER_SIZE];

    convert(buffer, 14);
    TEST_ASSERT_EQUAL_STRING("Plong", buffer);
}

void test_the_sound_for_15_is_plingplang_as_it_has_factors_3_and_5(void) {
    TEST_IGNORE();
    char buffer[BUFFER_SIZE];

    convert(buffer, 15);
    TEST_ASSERT_EQUAL_STRING("PlingPlang", buffer);
}

void test_the_sound_for_21_is_plingplong_as_it_has_factors_3_and_7(void) {
    TEST_IGNORE();
    char buffer[BUFFER_SIZE];

    convert(buffer, 21);
    TEST_ASSERT_EQUAL_STRING("PlingPlong", buffer);
}

void test_the_sound_for_25_is_plang_as_it_has_a_factor_5(void) {
    TEST_IGNORE();
    char buffer[BUFFER_SIZE];

    convert(buffer, 25);
    TEST_ASSERT_EQUAL_STRING("Plang", buffer);
}

void test_the_sound_for_27_is_pling_as_it_has_a_factor_3(void) {
    TEST_IGNORE();
    char buffer[BUFFER_SIZE];

    convert(buffer, 27);
    TEST_ASSERT_EQUAL_STRING("Pling", buffer);
}

void test_the_sound_for_35_is_plangplong_as_it_has_factors_5_and_7(void) {
    TEST_IGNORE();
    char buffer[BUFFER_SIZE];

    convert(buffer, 35);
    TEST_ASSERT_EQUAL_STRING("PlangPlong", buffer);
}

void test_the_sound_for_49_is_plong_as_it_has_a_factor_7(void) {
    TEST_IGNORE();
    char buffer[BUFFER_SIZE];

    convert(buffer, 49);
    TEST_ASSERT_EQUAL_STRING("Plong", buffer);
}

void test_the_sound_for_52_is_52(void) {
    TEST_IGNORE();
    char buffer[BUFFER_SIZE];

    convert(buffer, 52);
    TEST_ASSERT_EQUAL_STRING("52", buffer);
}

void test_the_sound_for_105_is_plingplangplong_as_it_has_factors_3_5_and_7(void) {
    TEST_IGNORE();
    char buffer[BUFFER_SIZE];

    convert(buffer, 105);
    TEST_ASSERT_EQUAL_STRING("PlingPlangPlong", buffer);
}

void test_the_sound_for_3125_is_plang_as_it_has_a_factor_5(void) {
    TEST_IGNORE();
    char buffer[BUFFER_SIZE];

    convert(buffer, 3125);
    TEST_ASSERT_EQUAL_STRING("Plang", buffer);
}

void test_three_digit_prime(void) {
    TEST_IGNORE();
    char buffer[BUFFER_SIZE];

    convert(buffer, 829);
    TEST_ASSERT_EQUAL_STRING("829", buffer);
}

void test_large_positive(void) {
    TEST_IGNORE();
    char buffer[BUFFER_SIZE];

    convert(buffer, 9223372036854775905U);
    TEST_ASSERT_EQUAL_STRING("PlingPlangPlong", buffer);
}

int main(void) {
    UNITY_BEGIN();
    RUN_TEST(test_the_sound_for_1_is_1);
    RUN_TEST(test_the_sound_for_3_is_pling);
    RUN_TEST(test_the_sound_for_5_is_plang);
    RUN_TEST(test_the_sound_for_7_is_plong);
    RUN_TEST(test_the_sound_for_6_is_pling_as_it_has_a_factor_3);
    RUN_TEST(test_2_to_the_power_3_does_not_make_a_raindrop_sound_as_3_is_the_exponent_not_the_base);
    RUN_TEST(test_the_sound_for_9_is_pling_as_it_has_a_factor_3);
    RUN_TEST(test_the_sound_for_10_is_plang_as_it_has_a_factor_5);
    RUN_TEST(test_the_sound_for_14_is_plong_as_it_has_a_factor_of_7);
    RUN_TEST(test_the_sound_for_15_is_plingplang_as_it_has_factors_3_and_5);
    RUN_TEST(test_the_sound_for_21_is_plingplong_as_it_has_factors_3_and_7);
    RUN_TEST(test_the_sound_for_25_is_plang_as_it_has_a_factor_5);
    RUN_TEST(test_the_sound_for_27_is_pling_as_it_has_a_factor_3);
    RUN_TEST(test_the_sound_for_35_is_plangplong_as_it_has_factors_5_and_7);
    RUN_TEST(test_the_sound_for_49_is_plong_as_it_has_a_factor_7);
    RUN_TEST(test_the_sound_for_52_is_52);
    RUN_TEST(test_the_sound_for_105_is_plingplangplong_as_it_has_factors_3_5_and_7);
    RUN_TEST(test_the_sound_for_3125_is_plang_as_it_has_a_factor_5);
    RUN_TEST(test_three_digit_prime);
    RUN_TEST(test_large_positive);
    return UNITY_END();
}
