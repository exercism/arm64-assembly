#include "vendor/unity.h"

#define UNEQUAL_LENGTHS -1

extern int distance(const char *strand1, const char *strand2);

void setUp(void) {
}

void tearDown(void) {
}

void test_empty_strands(void) {
    TEST_ASSERT_EQUAL_INT(0, distance("", ""));
}

void test_single_letter_identical_strands(void) {
    TEST_IGNORE();
    TEST_ASSERT_EQUAL_INT(0, distance("A", "A"));
}

void test_single_letter_different_strands(void) {
    TEST_IGNORE();
    TEST_ASSERT_EQUAL_INT(1, distance("G", "T"));
}

void test_long_identical_strands(void) {
    TEST_IGNORE();
    TEST_ASSERT_EQUAL_INT(0, distance("GGACTGAAATCTG", "GGACTGAAATCTG"));
}

void test_long_different_strands(void) {
    TEST_IGNORE();
    TEST_ASSERT_EQUAL_INT(9, distance("GGACGGATTCTG", "AGGACGGATTCT"));
}

void test_disallow_first_strand_longer(void) {
    TEST_IGNORE();
    TEST_ASSERT_EQUAL_INT(UNEQUAL_LENGTHS, distance("AATG", "AAA"));
}

void test_disallow_second_strand_longer(void) {
    TEST_IGNORE();
    TEST_ASSERT_EQUAL_INT(UNEQUAL_LENGTHS, distance("ATA", "AGTG"));
}

void test_disallow_empty_first_strand(void) {
    TEST_IGNORE();
    TEST_ASSERT_EQUAL_INT(UNEQUAL_LENGTHS, distance("", "G"));
}

void test_disallow_empty_second_strand(void) {
    TEST_IGNORE();
    TEST_ASSERT_EQUAL_INT(UNEQUAL_LENGTHS, distance("G", ""));
}

int main(void) {
    UNITY_BEGIN();
    RUN_TEST(test_empty_strands);
    RUN_TEST(test_single_letter_identical_strands);
    RUN_TEST(test_single_letter_different_strands);
    RUN_TEST(test_long_identical_strands);
    RUN_TEST(test_long_different_strands);
    RUN_TEST(test_disallow_first_strand_longer);
    RUN_TEST(test_disallow_second_strand_longer);
    RUN_TEST(test_disallow_empty_first_strand);
    RUN_TEST(test_disallow_empty_second_strand);
    return UNITY_END();
}
