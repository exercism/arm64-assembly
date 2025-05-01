#include "vendor/unity.h"

#include <stddef.h>

extern int value(const char **colors);

void setUp(void) {
}

void tearDown(void) {
}

void test_brown_and_black(void) {
    const char *colors[] = {"brown", "black", NULL};
    TEST_ASSERT_EQUAL_INT(10, value(colors));
}

void test_blue_and_grey(void) {
    TEST_IGNORE();
    const char *colors[] = {"blue", "grey", NULL};
    TEST_ASSERT_EQUAL_INT(68, value(colors));
}

void test_yellow_and_violet(void) {
    TEST_IGNORE();
    const char *colors[] = {"yellow", "violet", NULL};
    TEST_ASSERT_EQUAL_INT(47, value(colors));
}

void test_white_and_red(void) {
    TEST_IGNORE();
    const char *colors[] = {"white", "red", NULL};
    TEST_ASSERT_EQUAL_INT(92, value(colors));
}

void test_orange_and_orange(void) {
    TEST_IGNORE();
    const char *colors[] = {"orange", "orange", NULL};
    TEST_ASSERT_EQUAL_INT(33, value(colors));
}

void test_ignore_additional_colors(void) {
    TEST_IGNORE();
    const char *colors[] = {"green", "brown", "orange", NULL};
    TEST_ASSERT_EQUAL_INT(51, value(colors));
}

void test_black_and_brown_onedigit(void) {
    TEST_IGNORE();
    const char *colors[] = {"black", "brown", NULL};
    TEST_ASSERT_EQUAL_INT(1, value(colors));
}

int main(void) {
    UNITY_BEGIN();
    RUN_TEST(test_brown_and_black);
    RUN_TEST(test_blue_and_grey);
    RUN_TEST(test_yellow_and_violet);
    RUN_TEST(test_white_and_red);
    RUN_TEST(test_orange_and_orange);
    RUN_TEST(test_ignore_additional_colors);
    RUN_TEST(test_black_and_brown_onedigit);
    return UNITY_END();
}
