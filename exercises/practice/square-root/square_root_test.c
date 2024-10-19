#include "vendor/unity.h"

#include <stdint.h>

extern uint64_t square_root(uint64_t radicand);

void setUp(void) {
}

void tearDown(void) {
}

void test_root_of_1(void) {
    TEST_ASSERT_EQUAL_INT(1, square_root(1));
}

void test_root_of_4(void) {
    TEST_IGNORE();
    TEST_ASSERT_EQUAL_INT(2, square_root(4));
}

void test_root_of_25(void) {
    TEST_IGNORE();
    TEST_ASSERT_EQUAL_INT(5, square_root(25));
}

void test_root_of_81(void) {
    TEST_IGNORE();
    TEST_ASSERT_EQUAL_INT(9, square_root(81));
}

void test_root_of_196(void) {
    TEST_IGNORE();
    TEST_ASSERT_EQUAL_INT(14, square_root(196));
}

void test_root_of_65025(void) {
    TEST_IGNORE();
    TEST_ASSERT_EQUAL_INT(255, square_root(65025));
}

void test_root_of_4905601600(void) {
    TEST_IGNORE();
    TEST_ASSERT_EQUAL_INT(70040, square_root(4905601600));
}

int main(void) {
    UNITY_BEGIN();
    RUN_TEST(test_root_of_1);
    RUN_TEST(test_root_of_4);
    RUN_TEST(test_root_of_25);
    RUN_TEST(test_root_of_81);
    RUN_TEST(test_root_of_196);
    RUN_TEST(test_root_of_65025);
    RUN_TEST(test_root_of_4905601600);
    return UNITY_END();
}
