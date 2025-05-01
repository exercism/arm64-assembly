#include "vendor/unity.h"

#include <stddef.h>

extern int rectangles(const char **strings);

void setUp(void) {
}

void tearDown(void) {
}

void test_no_rows(void) {
    const char *strings[] = {
        // clang-format off
        NULL
        // clang-format on
    };
    TEST_ASSERT_EQUAL_INT(0, rectangles(strings));
}

void test_no_columns(void) {
    TEST_IGNORE();
    const char *strings[] = {
        // clang-format off
        "",
        NULL
        // clang-format on
    };
    TEST_ASSERT_EQUAL_INT(0, rectangles(strings));
}

void test_no_rectangles(void) {
    TEST_IGNORE();
    const char *strings[] = {
        // clang-format off
        " ",
        NULL
        // clang-format on
    };
    TEST_ASSERT_EQUAL_INT(0, rectangles(strings));
}

void test_one_rectangle(void) {
    TEST_IGNORE();
    const char *strings[] = {
        // clang-format off
        "+-+",
        "| |",
        "+-+",
        NULL
        // clang-format on
    };
    TEST_ASSERT_EQUAL_INT(1, rectangles(strings));
}

void test_two_rectangles_without_shared_parts(void) {
    TEST_IGNORE();
    const char *strings[] = {
        // clang-format off
        "  +-+",
        "  | |",
        "+-+-+",
        "| |  ",
        "+-+  ",
        NULL
        // clang-format on
    };
    TEST_ASSERT_EQUAL_INT(2, rectangles(strings));
}

void test_five_rectangles_with_shared_parts(void) {
    TEST_IGNORE();
    const char *strings[] = {
        // clang-format off
        "  +-+",
        "  | |",
        "+-+-+",
        "| | |",
        "+-+-+",
        NULL
        // clang-format on
    };
    TEST_ASSERT_EQUAL_INT(5, rectangles(strings));
}

void test_rectangle_of_height_1_is_counted(void) {
    TEST_IGNORE();
    const char *strings[] = {
        // clang-format off
        "+--+",
        "+--+",
        NULL
        // clang-format on
    };
    TEST_ASSERT_EQUAL_INT(1, rectangles(strings));
}

void test_rectangle_of_width_1_is_counted(void) {
    TEST_IGNORE();
    const char *strings[] = {
        // clang-format off
        "++",
        "||",
        "++",
        NULL
        // clang-format on
    };
    TEST_ASSERT_EQUAL_INT(1, rectangles(strings));
}

void test_1x1_square_is_counted(void) {
    TEST_IGNORE();
    const char *strings[] = {
        // clang-format off
        "++",
        "++",
        NULL
        // clang-format on
    };
    TEST_ASSERT_EQUAL_INT(1, rectangles(strings));
}

void test_only_complete_rectangles_are_counted(void) {
    TEST_IGNORE();
    const char *strings[] = {
        // clang-format off
        "  +-+",
        "    |",
        "+-+-+",
        "| | -",
        "+-+-+",
        NULL
        // clang-format on
    };
    TEST_ASSERT_EQUAL_INT(1, rectangles(strings));
}

void test_rectangles_can_be_of_different_sizes(void) {
    TEST_IGNORE();
    const char *strings[] = {
        // clang-format off
        "+------+----+",
        "|      |    |",
        "+---+--+    |",
        "|   |       |",
        "+---+-------+",
        NULL
        // clang-format on
    };
    TEST_ASSERT_EQUAL_INT(3, rectangles(strings));
}

void test_corner_is_required_for_a_rectangle_to_be_complete(void) {
    TEST_IGNORE();
    const char *strings[] = {
        // clang-format off
        "+------+----+",
        "|      |    |",
        "+------+    |",
        "|   |       |",
        "+---+-------+",
        NULL
        // clang-format on
    };
    TEST_ASSERT_EQUAL_INT(2, rectangles(strings));
}

void test_large_input_with_many_rectangles(void) {
    TEST_IGNORE();
    const char *strings[] = {
        // clang-format off
        "+---+--+----+",
        "|   +--+----+",
        "+---+--+    |",
        "|   +--+----+",
        "+---+--+--+-+",
        "+---+--+--+-+",
        "+------+  | |",
        "          +-+",
        NULL
        // clang-format on
    };
    TEST_ASSERT_EQUAL_INT(60, rectangles(strings));
}

void test_rectangles_must_have_four_sides(void) {
    TEST_IGNORE();
    const char *strings[] = {
        // clang-format off
        "+-+ +-+",
        "| | | |",
        "+-+-+-+",
        "  | |  ",
        "+-+-+-+",
        "| | | |",
        "+-+ +-+",
        NULL
        // clang-format on
    };
    TEST_ASSERT_EQUAL_INT(5, rectangles(strings));
}

void test_very_large_input(void) {
    TEST_IGNORE();
    const char *strings[] = {
        // clang-format off
        "      +-----+--------+    +-----+ ",
        "++---++-----+--------+---++-----++",
        "||+--++-----+-+-++   |   ||     ||",
        "|||  ||     +-+-++-+ |   ||     ||",
        "|||  ||     | | || | |   ||     ||",
        "||| +++-----+-+-++-+-+---++-+   ||",
        "||| |||     | | || | |+--++-+-+ ||",
        "||| +++---+-+-+-++-+-++--++-+ | ||",
        "||| |||+--+-+-+-+| | |+--++---+ ||",
        "||| ||||  | | | || | |+-+||     ||",
        "||+-++++--+-+++-++-+-++-+++---++||",
        "||  |+++--+-+++-+--+-+| |||   ||||",
        "+++-+++++---++--+-++-++-+++---+|||",
        " |+-+++++---++--+ || || |||   ||||",
        " |  +++++---++--+-++-++-++++  ||||",
        " |   ||||   |+----++-++-++++--+++|",
        " |   |+++---+|    || || ||    || |",
        "+++  |||+---++----+| || ||    || |",
        "|||  +++----++----++-++-++----++-+",
        "+++---++----++-----+-++-++----++  ",
        "                      +-+         ",
        NULL
        // clang-format on
    };
    TEST_ASSERT_EQUAL_INT(2063, rectangles(strings));
}

int main(void) {
    UNITY_BEGIN();
    RUN_TEST(test_no_rows);
    RUN_TEST(test_no_columns);
    RUN_TEST(test_no_rectangles);
    RUN_TEST(test_one_rectangle);
    RUN_TEST(test_two_rectangles_without_shared_parts);
    RUN_TEST(test_five_rectangles_with_shared_parts);
    RUN_TEST(test_rectangle_of_height_1_is_counted);
    RUN_TEST(test_rectangle_of_width_1_is_counted);
    RUN_TEST(test_1x1_square_is_counted);
    RUN_TEST(test_only_complete_rectangles_are_counted);
    RUN_TEST(test_rectangles_can_be_of_different_sizes);
    RUN_TEST(test_corner_is_required_for_a_rectangle_to_be_complete);
    RUN_TEST(test_large_input_with_many_rectangles);
    RUN_TEST(test_rectangles_must_have_four_sides);
    RUN_TEST(test_very_large_input);
    return UNITY_END();
}
