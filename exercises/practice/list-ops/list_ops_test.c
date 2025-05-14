#include "vendor/unity.h"

#include <stdbool.h>
#include <stddef.h>
#include <stdint.h>

#define BUFFER_SIZE 16

#define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))

extern size_t append(int64_t *buffer, const int64_t *list1, size_t list1_count, const int64_t *list2, size_t list2_count);
extern size_t filter(int64_t *buffer, const int64_t *list, size_t list_count, bool (*function)(int64_t));
extern size_t map(int64_t *buffer, const int64_t *list, size_t list_count, int64_t (*function)(int64_t));
extern int64_t foldl(const int64_t *list, size_t list_count, int64_t initial, int64_t (*function)(int64_t, int64_t));
extern int64_t foldr(const int64_t *list, size_t list_count, int64_t initial, int64_t (*function)(int64_t, int64_t));
extern size_t reverse(int64_t *buffer, const int64_t *list, size_t list_count);

static bool is_odd(int64_t x) {
    return x % 2 == 1;
}

static int64_t plus_one(int64_t x) {
    return x + 1;
}

static int64_t multiply(int64_t acc, int64_t el) {
    return el * acc;
}

static int64_t add(int64_t acc, int64_t el) {
    return el + acc;
}

static int64_t divide(int64_t acc, int64_t el) {
    return acc == 0 ? 0 : el / acc;
}

void setUp(void) {
}

void tearDown(void) {
}

void test_append_empty_lists(void) {
    int64_t buffer[BUFFER_SIZE];
    TEST_ASSERT_EQUAL_UINT(0U, append(buffer, NULL, 0, NULL, 0));
}

void test_append_list_to_empty_list(void) {
    TEST_IGNORE();
    const int64_t list2[] = {1, 2, 3, 4};
    int64_t buffer[BUFFER_SIZE];
    const int64_t expected[] = {1, 2, 3, 4};
    TEST_ASSERT_EQUAL_UINT(ARRAY_SIZE(expected), append(buffer, NULL, 0, list2, ARRAY_SIZE(list2)));
    TEST_ASSERT_EQUAL_INT64_ARRAY(expected, buffer, ARRAY_SIZE(expected));
}

void test_append_empty_list_to_list(void) {
    TEST_IGNORE();
    const int64_t list1[] = {1, 2, 3, 4};
    int64_t buffer[BUFFER_SIZE];
    const int64_t expected[] = {1, 2, 3, 4};
    TEST_ASSERT_EQUAL_UINT(ARRAY_SIZE(expected), append(buffer, list1, ARRAY_SIZE(list1), NULL, 0));
    TEST_ASSERT_EQUAL_INT64_ARRAY(expected, buffer, ARRAY_SIZE(expected));
}

void test_append_nonempty_lists(void) {
    TEST_IGNORE();
    const int64_t list1[] = {1, 2};
    const int64_t list2[] = {2, 3, 4, 5};
    int64_t buffer[BUFFER_SIZE];
    const int64_t expected[] = {1, 2, 2, 3, 4, 5};
    TEST_ASSERT_EQUAL_UINT(ARRAY_SIZE(expected), append(buffer, list1, ARRAY_SIZE(list1), list2, ARRAY_SIZE(list2)));
    TEST_ASSERT_EQUAL_INT64_ARRAY(expected, buffer, ARRAY_SIZE(expected));
}

void test_filter_empty_list(void) {
    TEST_IGNORE();
    int64_t buffer[BUFFER_SIZE];
    TEST_ASSERT_EQUAL_UINT(0U, filter(buffer, NULL, 0, is_odd));
}

void test_filter_nonempty_list(void) {
    TEST_IGNORE();
    const int64_t list[] = {1, 2, 3, 5};
    int64_t buffer[BUFFER_SIZE];
    const int64_t expected[] = {1, 3, 5};
    TEST_ASSERT_EQUAL_UINT(ARRAY_SIZE(expected), filter(buffer, list, ARRAY_SIZE(list), is_odd));
    TEST_ASSERT_EQUAL_INT64_ARRAY(expected, buffer, ARRAY_SIZE(expected));
}

void test_map_empty_list(void) {
    TEST_IGNORE();
    int64_t buffer[BUFFER_SIZE];
    TEST_ASSERT_EQUAL_UINT(0U, map(buffer, NULL, 0, plus_one));
}

void test_map_nonempty_list(void) {
    TEST_IGNORE();
    const int64_t list[] = {1, 3, 5, 7};
    int64_t buffer[BUFFER_SIZE];
    const int64_t expected[] = {2, 4, 6, 8};
    TEST_ASSERT_EQUAL_UINT(ARRAY_SIZE(expected), map(buffer, list, ARRAY_SIZE(list), plus_one));
    TEST_ASSERT_EQUAL_INT64_ARRAY(expected, buffer, ARRAY_SIZE(expected));
}

void test_foldl_empty_list(void) {
    TEST_IGNORE();
    TEST_ASSERT_EQUAL_INT(2, foldl(NULL, 0, 2, multiply));
}

void test_foldl_direction_independent_function_applied_to_nonempty_list(void) {
    TEST_IGNORE();
    const int64_t list[] = {1, 2, 3, 4};
    TEST_ASSERT_EQUAL_INT(15, foldl(list, ARRAY_SIZE(list), 5, add));
}

void test_foldl_direction_dependent_function_applied_to_nonempty_list(void) {
    TEST_IGNORE();
    const int64_t list[] = {2, 5};
    TEST_ASSERT_EQUAL_INT(0, foldl(list, ARRAY_SIZE(list), 5, divide));
}

void test_foldr_empty_list(void) {
    TEST_IGNORE();
    TEST_ASSERT_EQUAL_INT(2, foldr(NULL, 0, 2, multiply));
}

void test_foldr_direction_independent_function_applied_to_nonempty_list(void) {
    TEST_IGNORE();
    const int64_t list[] = {1, 2, 3, 4};
    TEST_ASSERT_EQUAL_INT(15, foldr(list, ARRAY_SIZE(list), 5, add));
}

void test_foldr_direction_dependent_function_applied_to_nonempty_list(void) {
    TEST_IGNORE();
    const int64_t list[] = {2, 5};
    TEST_ASSERT_EQUAL_INT(2, foldr(list, ARRAY_SIZE(list), 5, divide));
}

void test_reverse_empty_list(void) {
    TEST_IGNORE();
    int64_t buffer[BUFFER_SIZE];
    TEST_ASSERT_EQUAL_UINT(0U, reverse(buffer, NULL, 0));
}

void test_reverse_nonempty_list(void) {
    TEST_IGNORE();
    const int64_t list[] = {1, 3, 5, 7};
    int64_t buffer[BUFFER_SIZE];
    const int64_t expected[] = {7, 5, 3, 1};
    TEST_ASSERT_EQUAL_UINT(ARRAY_SIZE(expected), reverse(buffer, list, ARRAY_SIZE(list)));
    TEST_ASSERT_EQUAL_INT64_ARRAY(expected, buffer, ARRAY_SIZE(expected));
}

int main(void) {
    UNITY_BEGIN();
    RUN_TEST(test_append_empty_lists);
    RUN_TEST(test_append_list_to_empty_list);
    RUN_TEST(test_append_empty_list_to_list);
    RUN_TEST(test_append_nonempty_lists);
    RUN_TEST(test_filter_empty_list);
    RUN_TEST(test_filter_nonempty_list);
    RUN_TEST(test_map_empty_list);
    RUN_TEST(test_map_nonempty_list);
    RUN_TEST(test_foldl_empty_list);
    RUN_TEST(test_foldl_direction_independent_function_applied_to_nonempty_list);
    RUN_TEST(test_foldl_direction_dependent_function_applied_to_nonempty_list);
    RUN_TEST(test_foldr_empty_list);
    RUN_TEST(test_foldr_direction_independent_function_applied_to_nonempty_list);
    RUN_TEST(test_foldr_direction_dependent_function_applied_to_nonempty_list);
    RUN_TEST(test_reverse_empty_list);
    RUN_TEST(test_reverse_nonempty_list);
    return UNITY_END();
}
