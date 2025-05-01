#include "vendor/unity.h"

#include <stddef.h>
#include <stdint.h>

#define MAX_ARRAY_SIZE 100
#define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))

extern size_t factors(uint64_t *dest, uint64_t value);

void setUp(void) {
}

void tearDown(void) {
}

void test_no_factors(void) {
    uint64_t actual[MAX_ARRAY_SIZE];
    const size_t size = factors(actual, 1);
    TEST_ASSERT_EQUAL_UINT(0U, size);
}

void test_prime_number(void) {
    TEST_IGNORE();
    const uint64_t expected[] = {2};
    uint64_t actual[MAX_ARRAY_SIZE];
    const size_t size = factors(actual, 2);
    TEST_ASSERT_EQUAL_UINT(ARRAY_SIZE(expected), size);
    TEST_ASSERT_EQUAL_UINT64_ARRAY(expected, actual, size);
}

void test_another_prime_number(void) {
    TEST_IGNORE();
    const uint64_t expected[] = {3};
    uint64_t actual[MAX_ARRAY_SIZE];
    const size_t size = factors(actual, 3);
    TEST_ASSERT_EQUAL_UINT(ARRAY_SIZE(expected), size);
    TEST_ASSERT_EQUAL_UINT64_ARRAY(expected, actual, size);
}

void test_square_of_a_prime(void) {
    TEST_IGNORE();
    const uint64_t expected[] = {3, 3};
    uint64_t actual[MAX_ARRAY_SIZE];
    const size_t size = factors(actual, 9);
    TEST_ASSERT_EQUAL_UINT(ARRAY_SIZE(expected), size);
    TEST_ASSERT_EQUAL_UINT64_ARRAY(expected, actual, size);
}

void test_product_of_first_prime(void) {
    TEST_IGNORE();
    const uint64_t expected[] = {2, 2};
    uint64_t actual[MAX_ARRAY_SIZE];
    const size_t size = factors(actual, 4);
    TEST_ASSERT_EQUAL_UINT(ARRAY_SIZE(expected), size);
    TEST_ASSERT_EQUAL_UINT64_ARRAY(expected, actual, size);
}

void test_cube_of_a_prime(void) {
    TEST_IGNORE();
    const uint64_t expected[] = {2, 2, 2};
    uint64_t actual[MAX_ARRAY_SIZE];
    const size_t size = factors(actual, 8);
    TEST_ASSERT_EQUAL_UINT(ARRAY_SIZE(expected), size);
    TEST_ASSERT_EQUAL_UINT64_ARRAY(expected, actual, size);
}

void test_product_of_second_prime(void) {
    TEST_IGNORE();
    const uint64_t expected[] = {3, 3, 3};
    uint64_t actual[MAX_ARRAY_SIZE];
    const size_t size = factors(actual, 27);
    TEST_ASSERT_EQUAL_UINT(ARRAY_SIZE(expected), size);
    TEST_ASSERT_EQUAL_UINT64_ARRAY(expected, actual, size);
}

void test_product_of_third_prime(void) {
    TEST_IGNORE();
    const uint64_t expected[] = {5, 5, 5, 5};
    uint64_t actual[MAX_ARRAY_SIZE];
    const size_t size = factors(actual, 625);
    TEST_ASSERT_EQUAL_UINT(ARRAY_SIZE(expected), size);
    TEST_ASSERT_EQUAL_UINT64_ARRAY(expected, actual, size);
}

void test_product_of_first_and_second_prime(void) {
    TEST_IGNORE();
    const uint64_t expected[] = {2, 3};
    uint64_t actual[MAX_ARRAY_SIZE];
    const size_t size = factors(actual, 6);
    TEST_ASSERT_EQUAL_UINT(ARRAY_SIZE(expected), size);
    TEST_ASSERT_EQUAL_UINT64_ARRAY(expected, actual, size);
}

void test_product_of_primes_and_nonprimes(void) {
    TEST_IGNORE();
    const uint64_t expected[] = {2, 2, 3};
    uint64_t actual[MAX_ARRAY_SIZE];
    const size_t size = factors(actual, 12);
    TEST_ASSERT_EQUAL_UINT(ARRAY_SIZE(expected), size);
    TEST_ASSERT_EQUAL_UINT64_ARRAY(expected, actual, size);
}

void test_product_of_primes(void) {
    TEST_IGNORE();
    const uint64_t expected[] = {5, 17, 23, 461};
    uint64_t actual[MAX_ARRAY_SIZE];
    const size_t size = factors(actual, 901255);
    TEST_ASSERT_EQUAL_UINT(ARRAY_SIZE(expected), size);
    TEST_ASSERT_EQUAL_UINT64_ARRAY(expected, actual, size);
}

void test_factors_include_a_large_prime(void) {
    TEST_IGNORE();
    const uint64_t expected[] = {11, 9539, 894119};
    uint64_t actual[MAX_ARRAY_SIZE];
    const size_t size = factors(actual, 93819012551);
    TEST_ASSERT_EQUAL_UINT(ARRAY_SIZE(expected), size);
    TEST_ASSERT_EQUAL_UINT64_ARRAY(expected, actual, size);
}

void test_product_of_three_large_primes(void) {
    TEST_IGNORE();
    const uint64_t expected[] = {2077681, 2099191, 2101243};
    uint64_t actual[MAX_ARRAY_SIZE];
    const size_t size = factors(actual, 9164464719174396253);
    TEST_ASSERT_EQUAL_UINT(ARRAY_SIZE(expected), size);
    TEST_ASSERT_EQUAL_UINT64_ARRAY(expected, actual, size);
}

void test_one_very_large_prime(void) {
    TEST_IGNORE();
    const uint64_t expected[] = {4016465016163};
    uint64_t actual[MAX_ARRAY_SIZE];
    const size_t size = factors(actual, 4016465016163);
    TEST_ASSERT_EQUAL_UINT(ARRAY_SIZE(expected), size);
    TEST_ASSERT_EQUAL_UINT64_ARRAY(expected, actual, size);
}

int main(void) {
    UNITY_BEGIN();
    RUN_TEST(test_no_factors);
    RUN_TEST(test_prime_number);
    RUN_TEST(test_another_prime_number);
    RUN_TEST(test_square_of_a_prime);
    RUN_TEST(test_product_of_first_prime);
    RUN_TEST(test_cube_of_a_prime);
    RUN_TEST(test_product_of_second_prime);
    RUN_TEST(test_product_of_third_prime);
    RUN_TEST(test_product_of_first_and_second_prime);
    RUN_TEST(test_product_of_primes_and_nonprimes);
    RUN_TEST(test_product_of_primes);
    RUN_TEST(test_factors_include_a_large_prime);
    RUN_TEST(test_product_of_three_large_primes);
    RUN_TEST(test_one_very_large_prime);
    return UNITY_END();
}
