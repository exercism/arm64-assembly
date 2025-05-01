#include "vendor/unity.h"

#define BUFFER_SIZE 3200

extern void rows(char *buffer, char letter);

void setUp(void) {
}

void tearDown(void) {
}

void test_degenerate_case_with_a_single_a_row(void) {
    const char expected[] = "A\n";
    char buffer[BUFFER_SIZE];

    rows(buffer, 'A');
    TEST_ASSERT_EQUAL_STRING(expected, buffer);
}

void test_degenerate_case_with_no_row_containing_3_distinct_groups_of_spaces(void) {
    TEST_IGNORE();
    const char expected[] =
        " A \n"
        "B B\n"
        " A \n";
    char buffer[BUFFER_SIZE];

    rows(buffer, 'B');
    TEST_ASSERT_EQUAL_STRING(expected, buffer);
}

void test_smallest_nondegenerate_case_with_odd_diamond_side_length(void) {
    TEST_IGNORE();
    const char expected[] =
        "  A  \n"
        " B B \n"
        "C   C\n"
        " B B \n"
        "  A  \n";
    char buffer[BUFFER_SIZE];

    rows(buffer, 'C');
    TEST_ASSERT_EQUAL_STRING(expected, buffer);
}

void test_smallest_nondegenerate_case_with_even_diamond_side_length(void) {
    TEST_IGNORE();
    const char expected[] =
        "   A   \n"
        "  B B  \n"
        " C   C \n"
        "D     D\n"
        " C   C \n"
        "  B B  \n"
        "   A   \n";
    char buffer[BUFFER_SIZE];

    rows(buffer, 'D');
    TEST_ASSERT_EQUAL_STRING(expected, buffer);
}

void test_largest_possible_diamond(void) {
    TEST_IGNORE();
    const char expected[] =
        "                         A                         \n"
        "                        B B                        \n"
        "                       C   C                       \n"
        "                      D     D                      \n"
        "                     E       E                     \n"
        "                    F         F                    \n"
        "                   G           G                   \n"
        "                  H             H                  \n"
        "                 I               I                 \n"
        "                J                 J                \n"
        "               K                   K               \n"
        "              L                     L              \n"
        "             M                       M             \n"
        "            N                         N            \n"
        "           O                           O           \n"
        "          P                             P          \n"
        "         Q                               Q         \n"
        "        R                                 R        \n"
        "       S                                   S       \n"
        "      T                                     T      \n"
        "     U                                       U     \n"
        "    V                                         V    \n"
        "   W                                           W   \n"
        "  X                                             X  \n"
        " Y                                               Y \n"
        "Z                                                 Z\n"
        " Y                                               Y \n"
        "  X                                             X  \n"
        "   W                                           W   \n"
        "    V                                         V    \n"
        "     U                                       U     \n"
        "      T                                     T      \n"
        "       S                                   S       \n"
        "        R                                 R        \n"
        "         Q                               Q         \n"
        "          P                             P          \n"
        "           O                           O           \n"
        "            N                         N            \n"
        "             M                       M             \n"
        "              L                     L              \n"
        "               K                   K               \n"
        "                J                 J                \n"
        "                 I               I                 \n"
        "                  H             H                  \n"
        "                   G           G                   \n"
        "                    F         F                    \n"
        "                     E       E                     \n"
        "                      D     D                      \n"
        "                       C   C                       \n"
        "                        B B                        \n"
        "                         A                         \n";
    char buffer[BUFFER_SIZE];

    rows(buffer, 'Z');
    TEST_ASSERT_EQUAL_STRING(expected, buffer);
}

int main(void) {
    UNITY_BEGIN();
    RUN_TEST(test_degenerate_case_with_a_single_a_row);
    RUN_TEST(test_degenerate_case_with_no_row_containing_3_distinct_groups_of_spaces);
    RUN_TEST(test_smallest_nondegenerate_case_with_odd_diamond_side_length);
    RUN_TEST(test_smallest_nondegenerate_case_with_even_diamond_side_length);
    RUN_TEST(test_largest_possible_diamond);
    return UNITY_END();
}
