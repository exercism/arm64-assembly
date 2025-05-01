#include "vendor/unity.h"

#include <stddef.h>
#include <stdint.h>

#define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))

typedef struct {
    uint32_t weight;
    uint32_t value;
} item_t;

extern uint32_t maximum_value(uint32_t maximum_weight, const item_t *items, size_t item_count);

void setUp(void) {
}

void tearDown(void) {
}

void test_no_items(void) {
    TEST_ASSERT_EQUAL_UINT(0, maximum_value(100, NULL, 0));
}

void test_one_item_too_heavy(void) {
    TEST_IGNORE();
    const item_t items[] = {{100, 1}};
    TEST_ASSERT_EQUAL_UINT(0, maximum_value(10, items, ARRAY_SIZE(items)));
}

void test_five_items_cannot_be_greedy_by_weight(void) {
    TEST_IGNORE();
    const item_t items[] = {{2, 5}, {2, 5}, {2, 5}, {2, 5}, {10, 21}};
    TEST_ASSERT_EQUAL_UINT(21, maximum_value(10, items, ARRAY_SIZE(items)));
}

void test_five_items_cannot_be_greedy_by_value(void) {
    TEST_IGNORE();
    const item_t items[] = {{2, 20}, {2, 20}, {2, 20}, {2, 20}, {10, 50}};
    TEST_ASSERT_EQUAL_UINT(80, maximum_value(10, items, ARRAY_SIZE(items)));
}

void test_example_knapsack(void) {
    TEST_IGNORE();
    const item_t items[] = {{5, 10}, {4, 40}, {6, 30}, {4, 50}};
    TEST_ASSERT_EQUAL_UINT(90, maximum_value(10, items, ARRAY_SIZE(items)));
}

void test_8_items(void) {
    TEST_IGNORE();
    const item_t items[] = {{25, 350}, {35, 400}, {45, 450}, {5, 20}, {25, 70}, {3, 8}, {2, 5}, {2, 5}};
    TEST_ASSERT_EQUAL_UINT(900, maximum_value(104, items, ARRAY_SIZE(items)));
}

void test_15_items(void) {
    TEST_IGNORE();
    const item_t items[] = {{70, 135}, {73, 139},  {77, 149},  {80, 150},  {82, 156},  {87, 163},  {90, 173}, {94, 184},
                            {98, 192}, {106, 201}, {110, 210}, {113, 214}, {115, 221}, {118, 229}, {120, 240}};
    TEST_ASSERT_EQUAL_UINT(1458, maximum_value(750, items, ARRAY_SIZE(items)));
}

int main(void) {
    UNITY_BEGIN();
    RUN_TEST(test_no_items);
    RUN_TEST(test_one_item_too_heavy);
    RUN_TEST(test_five_items_cannot_be_greedy_by_weight);
    RUN_TEST(test_five_items_cannot_be_greedy_by_value);
    RUN_TEST(test_example_knapsack);
    RUN_TEST(test_8_items);
    RUN_TEST(test_15_items);
    return UNITY_END();
}
