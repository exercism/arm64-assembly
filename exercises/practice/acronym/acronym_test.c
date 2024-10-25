#include "vendor/unity.h"

#define BUFFER_SIZE 40

extern void abbreviate(char *buffer, const char *phrase);

void setUp(void) {
}

void tearDown(void) {
}

void test_basic(void) {
    char buffer[BUFFER_SIZE];

    abbreviate(buffer, "Portable Network Graphics");
    TEST_ASSERT_EQUAL_STRING("PNG", buffer);
}

void test_lowercase_words(void) {
    TEST_IGNORE();
    char buffer[BUFFER_SIZE];

    abbreviate(buffer, "Ruby on Rails");
    TEST_ASSERT_EQUAL_STRING("ROR", buffer);
}

void test_punctuation(void) {
    TEST_IGNORE();
    char buffer[BUFFER_SIZE];

    abbreviate(buffer, "First In, First Out");
    TEST_ASSERT_EQUAL_STRING("FIFO", buffer);
}

void test_all_caps_word(void) {
    TEST_IGNORE();
    char buffer[BUFFER_SIZE];

    abbreviate(buffer, "GNU Image Manipulation Program");
    TEST_ASSERT_EQUAL_STRING("GIMP", buffer);
}

void test_punctuation_without_whitespace(void) {
    TEST_IGNORE();
    char buffer[BUFFER_SIZE];

    abbreviate(buffer, "Complementary metal-oxide semiconductor");
    TEST_ASSERT_EQUAL_STRING("CMOS", buffer);
}

void test_very_long_abbreviation(void) {
    TEST_IGNORE();
    char buffer[BUFFER_SIZE];

    abbreviate(buffer, "Rolling On The Floor Laughing So Hard That My Dogs Came Over And Licked Me");
    TEST_ASSERT_EQUAL_STRING("ROTFLSHTMDCOALM", buffer);
}

void test_consecutive_delimiters(void) {
    TEST_IGNORE();
    char buffer[BUFFER_SIZE];

    abbreviate(buffer, "Something - I made up from thin air");
    TEST_ASSERT_EQUAL_STRING("SIMUFTA", buffer);
}

void test_apostrophes(void) {
    TEST_IGNORE();
    char buffer[BUFFER_SIZE];

    abbreviate(buffer, "Halley's Comet");
    TEST_ASSERT_EQUAL_STRING("HC", buffer);
}

void test_underscore_emphasis(void) {
    TEST_IGNORE();
    char buffer[BUFFER_SIZE];

    abbreviate(buffer, "The Road _Not_ Taken");
    TEST_ASSERT_EQUAL_STRING("TRNT", buffer);
}

int main(void) {
    UNITY_BEGIN();
    RUN_TEST(test_basic);
    RUN_TEST(test_lowercase_words);
    RUN_TEST(test_punctuation);
    RUN_TEST(test_all_caps_word);
    RUN_TEST(test_punctuation_without_whitespace);
    RUN_TEST(test_very_long_abbreviation);
    RUN_TEST(test_consecutive_delimiters);
    RUN_TEST(test_apostrophes);
    RUN_TEST(test_underscore_emphasis);
    return UNITY_END();
}
