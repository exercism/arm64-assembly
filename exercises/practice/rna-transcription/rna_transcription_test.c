#include "vendor/unity.h"

#define BUFFER_SIZE 80

extern void to_rna(char *buffer, const char *dna);

void setUp(void) {
}

void tearDown(void) {
}

void test_empty_rna_sequence(void) {
    char buffer[BUFFER_SIZE];

    to_rna(buffer, "");
    TEST_ASSERT_EQUAL_STRING("", buffer);
}

void test_rna_complement_of_cytosine_is_guanine(void) {
    TEST_IGNORE();
    char buffer[BUFFER_SIZE];

    to_rna(buffer, "C");
    TEST_ASSERT_EQUAL_STRING("G", buffer);
}

void test_rna_complement_of_guanine_is_cytosine(void) {
    TEST_IGNORE();
    char buffer[BUFFER_SIZE];

    to_rna(buffer, "G");
    TEST_ASSERT_EQUAL_STRING("C", buffer);
}

void test_rna_complement_of_thymine_is_adenine(void) {
    TEST_IGNORE();
    char buffer[BUFFER_SIZE];

    to_rna(buffer, "T");
    TEST_ASSERT_EQUAL_STRING("A", buffer);
}

void test_rna_complement_of_adenine_is_uracil(void) {
    TEST_IGNORE();
    char buffer[BUFFER_SIZE];

    to_rna(buffer, "A");
    TEST_ASSERT_EQUAL_STRING("U", buffer);
}

void test_rna_complement(void) {
    TEST_IGNORE();
    char buffer[BUFFER_SIZE];

    to_rna(buffer, "ACGTGGTCTTAA");
    TEST_ASSERT_EQUAL_STRING("UGCACCAGAAUU", buffer);
}

int main(void) {
    UNITY_BEGIN();
    RUN_TEST(test_empty_rna_sequence);
    RUN_TEST(test_rna_complement_of_cytosine_is_guanine);
    RUN_TEST(test_rna_complement_of_guanine_is_cytosine);
    RUN_TEST(test_rna_complement_of_thymine_is_adenine);
    RUN_TEST(test_rna_complement_of_adenine_is_uracil);
    RUN_TEST(test_rna_complement);
    return UNITY_END();
}
