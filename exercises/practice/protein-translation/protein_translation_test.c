#include "vendor/unity.h"

#define BUFFER_SIZE 80

extern void proteins(char *buffer, const char *strand);

void setUp(void) {
}

void tearDown(void) {
}

void test_empty_rna_sequence_results_in_no_proteins(void) {
    char buffer[BUFFER_SIZE];

    proteins(buffer, "");
    TEST_ASSERT_EQUAL_STRING("", buffer);
}

void test_methionine_rna_sequence(void) {
    TEST_IGNORE();
    char buffer[BUFFER_SIZE];

    proteins(buffer, "AUG");
    TEST_ASSERT_EQUAL_STRING("Methionine\n", buffer);
}

void test_phenylalanine_rna_sequence_1(void) {
    TEST_IGNORE();
    char buffer[BUFFER_SIZE];

    proteins(buffer, "UUU");
    TEST_ASSERT_EQUAL_STRING("Phenylalanine\n", buffer);
}

void test_phenylalanine_rna_sequence_2(void) {
    TEST_IGNORE();
    char buffer[BUFFER_SIZE];

    proteins(buffer, "UUC");
    TEST_ASSERT_EQUAL_STRING("Phenylalanine\n", buffer);
}

void test_leucine_rna_sequence_1(void) {
    TEST_IGNORE();
    char buffer[BUFFER_SIZE];

    proteins(buffer, "UUA");
    TEST_ASSERT_EQUAL_STRING("Leucine\n", buffer);
}

void test_leucine_rna_sequence_2(void) {
    TEST_IGNORE();
    char buffer[BUFFER_SIZE];

    proteins(buffer, "UUG");
    TEST_ASSERT_EQUAL_STRING("Leucine\n", buffer);
}

void test_serine_rna_sequence_1(void) {
    TEST_IGNORE();
    char buffer[BUFFER_SIZE];

    proteins(buffer, "UCU");
    TEST_ASSERT_EQUAL_STRING("Serine\n", buffer);
}

void test_serine_rna_sequence_2(void) {
    TEST_IGNORE();
    char buffer[BUFFER_SIZE];

    proteins(buffer, "UCC");
    TEST_ASSERT_EQUAL_STRING("Serine\n", buffer);
}

void test_serine_rna_sequence_3(void) {
    TEST_IGNORE();
    char buffer[BUFFER_SIZE];

    proteins(buffer, "UCA");
    TEST_ASSERT_EQUAL_STRING("Serine\n", buffer);
}

void test_serine_rna_sequence_4(void) {
    TEST_IGNORE();
    char buffer[BUFFER_SIZE];

    proteins(buffer, "UCG");
    TEST_ASSERT_EQUAL_STRING("Serine\n", buffer);
}

void test_tyrosine_rna_sequence_1(void) {
    TEST_IGNORE();
    char buffer[BUFFER_SIZE];

    proteins(buffer, "UAU");
    TEST_ASSERT_EQUAL_STRING("Tyrosine\n", buffer);
}

void test_tyrosine_rna_sequence_2(void) {
    TEST_IGNORE();
    char buffer[BUFFER_SIZE];

    proteins(buffer, "UAC");
    TEST_ASSERT_EQUAL_STRING("Tyrosine\n", buffer);
}

void test_cysteine_rna_sequence_1(void) {
    TEST_IGNORE();
    char buffer[BUFFER_SIZE];

    proteins(buffer, "UGU");
    TEST_ASSERT_EQUAL_STRING("Cysteine\n", buffer);
}

void test_cysteine_rna_sequence_2(void) {
    TEST_IGNORE();
    char buffer[BUFFER_SIZE];

    proteins(buffer, "UGC");
    TEST_ASSERT_EQUAL_STRING("Cysteine\n", buffer);
}

void test_tryptophan_rna_sequence(void) {
    TEST_IGNORE();
    char buffer[BUFFER_SIZE];

    proteins(buffer, "UGG");
    TEST_ASSERT_EQUAL_STRING("Tryptophan\n", buffer);
}

void test_stop_codon_rna_sequence_1(void) {
    TEST_IGNORE();
    char buffer[BUFFER_SIZE];

    proteins(buffer, "UAA");
    TEST_ASSERT_EQUAL_STRING("", buffer);
}

void test_stop_codon_rna_sequence_2(void) {
    TEST_IGNORE();
    char buffer[BUFFER_SIZE];

    proteins(buffer, "UAG");
    TEST_ASSERT_EQUAL_STRING("", buffer);
}

void test_stop_codon_rna_sequence_3(void) {
    TEST_IGNORE();
    char buffer[BUFFER_SIZE];

    proteins(buffer, "UGA");
    TEST_ASSERT_EQUAL_STRING("", buffer);
}

void test_sequence_of_two_protein_codons_translates_into_proteins(void) {
    TEST_IGNORE();
    char buffer[BUFFER_SIZE];

    proteins(buffer, "UUUUUU");
    TEST_ASSERT_EQUAL_STRING("Phenylalanine\nPhenylalanine\n", buffer);
}

void test_sequence_of_two_different_protein_codons_translates_into_proteins(void) {
    TEST_IGNORE();
    char buffer[BUFFER_SIZE];

    proteins(buffer, "UUAUUG");
    TEST_ASSERT_EQUAL_STRING("Leucine\nLeucine\n", buffer);
}

void test_translate_rna_strand_into_correct_protein_list(void) {
    TEST_IGNORE();
    char buffer[BUFFER_SIZE];

    proteins(buffer, "AUGUUUUGG");
    TEST_ASSERT_EQUAL_STRING("Methionine\nPhenylalanine\nTryptophan\n", buffer);
}

void test_translation_stops_if_stop_codon_at_beginning_of_sequence(void) {
    TEST_IGNORE();
    char buffer[BUFFER_SIZE];

    proteins(buffer, "UAGUGG");
    TEST_ASSERT_EQUAL_STRING("", buffer);
}

void test_translation_stops_if_stop_codon_at_end_of_twocodon_sequence(void) {
    TEST_IGNORE();
    char buffer[BUFFER_SIZE];

    proteins(buffer, "UGGUAG");
    TEST_ASSERT_EQUAL_STRING("Tryptophan\n", buffer);
}

void test_translation_stops_if_stop_codon_at_end_of_threecodon_sequence(void) {
    TEST_IGNORE();
    char buffer[BUFFER_SIZE];

    proteins(buffer, "AUGUUUUAA");
    TEST_ASSERT_EQUAL_STRING("Methionine\nPhenylalanine\n", buffer);
}

void test_translation_stops_if_stop_codon_in_middle_of_threecodon_sequence(void) {
    TEST_IGNORE();
    char buffer[BUFFER_SIZE];

    proteins(buffer, "UGGUAGUGG");
    TEST_ASSERT_EQUAL_STRING("Tryptophan\n", buffer);
}

void test_translation_stops_if_stop_codon_in_middle_of_sixcodon_sequence(void) {
    TEST_IGNORE();
    char buffer[BUFFER_SIZE];

    proteins(buffer, "UGGUGUUAUUAAUGGUUU");
    TEST_ASSERT_EQUAL_STRING("Tryptophan\nCysteine\nTyrosine\n", buffer);
}

void test_sequence_of_two_nonstop_codons_does_not_translate_to_a_stop_codon(void) {
    TEST_IGNORE();
    char buffer[BUFFER_SIZE];

    proteins(buffer, "AUGAUG");
    TEST_ASSERT_EQUAL_STRING("Methionine\nMethionine\n", buffer);
}

void test_unknown_amino_acids_not_part_of_a_codon_cant_translate(void) {
    TEST_IGNORE();
    char buffer[BUFFER_SIZE];

    proteins(buffer, "XYZ");
    TEST_ASSERT_EQUAL_STRING("", buffer);
}

void test_incomplete_rna_sequence_cant_translate(void) {
    TEST_IGNORE();
    char buffer[BUFFER_SIZE];

    proteins(buffer, "AUGU");
    TEST_ASSERT_EQUAL_STRING("", buffer);
}

void test_incomplete_rna_sequence_can_translate_if_valid_until_a_stop_codon(void) {
    TEST_IGNORE();
    char buffer[BUFFER_SIZE];

    proteins(buffer, "UUCUUCUAAUGGU");
    TEST_ASSERT_EQUAL_STRING("Phenylalanine\nPhenylalanine\n", buffer);
}

int main(void) {
    UNITY_BEGIN();
    RUN_TEST(test_empty_rna_sequence_results_in_no_proteins);
    RUN_TEST(test_methionine_rna_sequence);
    RUN_TEST(test_phenylalanine_rna_sequence_1);
    RUN_TEST(test_phenylalanine_rna_sequence_2);
    RUN_TEST(test_leucine_rna_sequence_1);
    RUN_TEST(test_leucine_rna_sequence_2);
    RUN_TEST(test_serine_rna_sequence_1);
    RUN_TEST(test_serine_rna_sequence_2);
    RUN_TEST(test_serine_rna_sequence_3);
    RUN_TEST(test_serine_rna_sequence_4);
    RUN_TEST(test_tyrosine_rna_sequence_1);
    RUN_TEST(test_tyrosine_rna_sequence_2);
    RUN_TEST(test_cysteine_rna_sequence_1);
    RUN_TEST(test_cysteine_rna_sequence_2);
    RUN_TEST(test_tryptophan_rna_sequence);
    RUN_TEST(test_stop_codon_rna_sequence_1);
    RUN_TEST(test_stop_codon_rna_sequence_2);
    RUN_TEST(test_stop_codon_rna_sequence_3);
    RUN_TEST(test_sequence_of_two_protein_codons_translates_into_proteins);
    RUN_TEST(test_sequence_of_two_different_protein_codons_translates_into_proteins);
    RUN_TEST(test_translate_rna_strand_into_correct_protein_list);
    RUN_TEST(test_translation_stops_if_stop_codon_at_beginning_of_sequence);
    RUN_TEST(test_translation_stops_if_stop_codon_at_end_of_twocodon_sequence);
    RUN_TEST(test_translation_stops_if_stop_codon_at_end_of_threecodon_sequence);
    RUN_TEST(test_translation_stops_if_stop_codon_in_middle_of_threecodon_sequence);
    RUN_TEST(test_translation_stops_if_stop_codon_in_middle_of_sixcodon_sequence);
    RUN_TEST(test_sequence_of_two_nonstop_codons_does_not_translate_to_a_stop_codon);
    RUN_TEST(test_unknown_amino_acids_not_part_of_a_codon_cant_translate);
    RUN_TEST(test_incomplete_rna_sequence_cant_translate);
    RUN_TEST(test_incomplete_rna_sequence_can_translate_if_valid_until_a_stop_codon);
    return UNITY_END();
}
