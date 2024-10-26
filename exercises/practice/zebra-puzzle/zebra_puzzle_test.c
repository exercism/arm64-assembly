#include "vendor/unity.h"

extern char drinks_water(void);
extern char owns_zebra(void);

void setUp(void) {
}

void tearDown(void) {
}

void test_resident_who_drinks_water(void) {
    TEST_ASSERT_EQUAL_INT('N', drinks_water());
}

void test_resident_who_owns_zebra(void) {
    TEST_IGNORE();
    TEST_ASSERT_EQUAL_INT('J', owns_zebra());
}

int main(void) {
    UNITY_BEGIN();
    RUN_TEST(test_resident_who_drinks_water);
    RUN_TEST(test_resident_who_owns_zebra);
    return UNITY_END();
}
