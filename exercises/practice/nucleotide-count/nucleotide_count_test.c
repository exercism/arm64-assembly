#include "vendor/unity.h"

#include <stdint.h>

#define INVALID -1

enum nucleotide {
    ADENINE,
    CYTOSINE,
    GUANINE,
    THYMINE
};

extern void nucleotide_counts(int16_t *counts, const char *strand);

void setUp(void) {
}

void tearDown(void) {
}

void test_empty_strand(void) {
    int16_t counts[4];
    nucleotide_counts(counts, "");
    TEST_ASSERT_EQUAL_INT(0, counts[ADENINE]);
    TEST_ASSERT_EQUAL_INT(0, counts[CYTOSINE]);
    TEST_ASSERT_EQUAL_INT(0, counts[GUANINE]);
    TEST_ASSERT_EQUAL_INT(0, counts[THYMINE]);
}

void test_can_count_one_nucleotide_in_singlecharacter_input(void) {
    TEST_IGNORE();
    int16_t counts[4];
    nucleotide_counts(counts, "G");
    TEST_ASSERT_EQUAL_INT(0, counts[ADENINE]);
    TEST_ASSERT_EQUAL_INT(0, counts[CYTOSINE]);
    TEST_ASSERT_EQUAL_INT(1, counts[GUANINE]);
    TEST_ASSERT_EQUAL_INT(0, counts[THYMINE]);
}

void test_strand_with_repeated_nucleotide(void) {
    TEST_IGNORE();
    int16_t counts[4];
    nucleotide_counts(counts, "GGGGGGG");
    TEST_ASSERT_EQUAL_INT(0, counts[ADENINE]);
    TEST_ASSERT_EQUAL_INT(0, counts[CYTOSINE]);
    TEST_ASSERT_EQUAL_INT(7, counts[GUANINE]);
    TEST_ASSERT_EQUAL_INT(0, counts[THYMINE]);
}

void test_strand_with_multiple_nucleotides(void) {
    TEST_IGNORE();
    int16_t counts[4];
    nucleotide_counts(counts, "AGCTTTTCATTCTGACTGCAACGGGCAATATGTCTCTGTGTGGATTAAAAAAAGAGTGTCTGATAGCAGC");
    TEST_ASSERT_EQUAL_INT(20, counts[ADENINE]);
    TEST_ASSERT_EQUAL_INT(12, counts[CYTOSINE]);
    TEST_ASSERT_EQUAL_INT(17, counts[GUANINE]);
    TEST_ASSERT_EQUAL_INT(21, counts[THYMINE]);
}

void test_strand_with_invalid_nucleotides(void) {
    TEST_IGNORE();
    int16_t counts[4];
    nucleotide_counts(counts, "AGXXACT");
    TEST_ASSERT_EQUAL_INT(INVALID, counts[ADENINE]);
    TEST_ASSERT_EQUAL_INT(INVALID, counts[CYTOSINE]);
    TEST_ASSERT_EQUAL_INT(INVALID, counts[GUANINE]);
    TEST_ASSERT_EQUAL_INT(INVALID, counts[THYMINE]);
}

int main(void) {
    UNITY_BEGIN();
    RUN_TEST(test_empty_strand);
    RUN_TEST(test_can_count_one_nucleotide_in_singlecharacter_input);
    RUN_TEST(test_strand_with_repeated_nucleotide);
    RUN_TEST(test_strand_with_multiple_nucleotides);
    RUN_TEST(test_strand_with_invalid_nucleotides);
    return UNITY_END();
}
