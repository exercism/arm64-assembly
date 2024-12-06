#include "vendor/unity.h"

#define BUFFER_SIZE 80

extern void rotate(char *buffer, const char *text, int shift_key);

void setUp(void) {
}

void tearDown(void) {
}

void test_rotate_a_by_0_same_output_as_input(void) {
    char buffer[BUFFER_SIZE];

    rotate(buffer, "a", 0);
    TEST_ASSERT_EQUAL_STRING("a", buffer);
}

void test_rotate_a_by_1(void) {
    TEST_IGNORE();
    char buffer[BUFFER_SIZE];

    rotate(buffer, "a", 1);
    TEST_ASSERT_EQUAL_STRING("b", buffer);
}

void test_rotate_a_by_26_same_output_as_input(void) {
    TEST_IGNORE();
    char buffer[BUFFER_SIZE];

    rotate(buffer, "a", 26);
    TEST_ASSERT_EQUAL_STRING("a", buffer);
}

void test_rotate_m_by_13(void) {
    TEST_IGNORE();
    char buffer[BUFFER_SIZE];

    rotate(buffer, "m", 13);
    TEST_ASSERT_EQUAL_STRING("z", buffer);
}

void test_rotate_n_by_13_with_wrap_around_alphabet(void) {
    TEST_IGNORE();
    char buffer[BUFFER_SIZE];

    rotate(buffer, "n", 13);
    TEST_ASSERT_EQUAL_STRING("a", buffer);
}

void test_rotate_capital_letters(void) {
    TEST_IGNORE();
    char buffer[BUFFER_SIZE];

    rotate(buffer, "OMG", 5);
    TEST_ASSERT_EQUAL_STRING("TRL", buffer);
}

void test_rotate_spaces(void) {
    TEST_IGNORE();
    char buffer[BUFFER_SIZE];

    rotate(buffer, "O M G", 5);
    TEST_ASSERT_EQUAL_STRING("T R L", buffer);
}

void test_rotate_numbers(void) {
    TEST_IGNORE();
    char buffer[BUFFER_SIZE];

    rotate(buffer, "Testing 1 2 3 testing", 4);
    TEST_ASSERT_EQUAL_STRING("Xiwxmrk 1 2 3 xiwxmrk", buffer);
}

void test_rotate_punctuation(void) {
    TEST_IGNORE();
    char buffer[BUFFER_SIZE];

    rotate(buffer, "Let's eat, Grandma!", 21);
    TEST_ASSERT_EQUAL_STRING("Gzo'n zvo, Bmviyhv!", buffer);
}

void test_rotate_all_letters(void) {
    TEST_IGNORE();
    char buffer[BUFFER_SIZE];

    rotate(buffer, "The quick brown fox jumps over the lazy dog.", 13);
    TEST_ASSERT_EQUAL_STRING("Gur dhvpx oebja sbk whzcf bire gur ynml qbt.", buffer);
}

void test_rotate_boundary_characters(void) {
    TEST_IGNORE();
    char buffer[BUFFER_SIZE];

    rotate(buffer, "/09:@AMNZ[`amnz{", 13);
    TEST_ASSERT_EQUAL_STRING("/09:@NZAM[`nzam{", buffer);
}

int main(void) {
    UNITY_BEGIN();
    RUN_TEST(test_rotate_a_by_0_same_output_as_input);
    RUN_TEST(test_rotate_a_by_1);
    RUN_TEST(test_rotate_a_by_26_same_output_as_input);
    RUN_TEST(test_rotate_m_by_13);
    RUN_TEST(test_rotate_n_by_13_with_wrap_around_alphabet);
    RUN_TEST(test_rotate_capital_letters);
    RUN_TEST(test_rotate_spaces);
    RUN_TEST(test_rotate_numbers);
    RUN_TEST(test_rotate_punctuation);
    RUN_TEST(test_rotate_all_letters);
    RUN_TEST(test_rotate_boundary_characters);
    return UNITY_END();
}
