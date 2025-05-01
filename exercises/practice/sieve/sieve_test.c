#include "vendor/unity.h"

#include <stddef.h>
#include <stdint.h>

#define MAX_ARRAY_SIZE 200
#define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))

extern size_t sieve(uint64_t *primes, uint64_t limit);

void setUp(void) {
}

void tearDown(void) {
}

void test_no_primes_under_two(void) {
    uint64_t actual[MAX_ARRAY_SIZE];
    const size_t size = sieve(actual, 1);
    TEST_ASSERT_EQUAL_UINT(0U, size);
}

void test_find_first_prime(void) {
    TEST_IGNORE();
    const uint64_t expected[] = {2};
    uint64_t actual[MAX_ARRAY_SIZE];
    const size_t size = sieve(actual, 2);
    TEST_ASSERT_EQUAL_UINT(ARRAY_SIZE(expected), size);
    TEST_ASSERT_EQUAL_UINT64_ARRAY(expected, actual, size);
}

void test_find_primes_up_to_10(void) {
    TEST_IGNORE();
    const uint64_t expected[] = {2, 3, 5, 7};
    uint64_t actual[MAX_ARRAY_SIZE];
    const size_t size = sieve(actual, 10);
    TEST_ASSERT_EQUAL_UINT(ARRAY_SIZE(expected), size);
    TEST_ASSERT_EQUAL_UINT64_ARRAY(expected, actual, size);
}

void test_limit_is_prime(void) {
    TEST_IGNORE();
    const uint64_t expected[] = {2, 3, 5, 7, 11, 13};
    uint64_t actual[MAX_ARRAY_SIZE];
    const size_t size = sieve(actual, 13);
    TEST_ASSERT_EQUAL_UINT(ARRAY_SIZE(expected), size);
    TEST_ASSERT_EQUAL_UINT64_ARRAY(expected, actual, size);
}

void test_find_primes_up_to_1000(void) {
    TEST_IGNORE();
    const uint64_t expected[] = {2,   3,   5,   7,   11,  13,  17,  19,  23,  29,  31,  37,  41,  43,  47,  53,  59,  61,  67,  71,  73,
                                 79,  83,  89,  97,  101, 103, 107, 109, 113, 127, 131, 137, 139, 149, 151, 157, 163, 167, 173, 179, 181,
                                 191, 193, 197, 199, 211, 223, 227, 229, 233, 239, 241, 251, 257, 263, 269, 271, 277, 281, 283, 293, 307,
                                 311, 313, 317, 331, 337, 347, 349, 353, 359, 367, 373, 379, 383, 389, 397, 401, 409, 419, 421, 431, 433,
                                 439, 443, 449, 457, 461, 463, 467, 479, 487, 491, 499, 503, 509, 521, 523, 541, 547, 557, 563, 569, 571,
                                 577, 587, 593, 599, 601, 607, 613, 617, 619, 631, 641, 643, 647, 653, 659, 661, 673, 677, 683, 691, 701,
                                 709, 719, 727, 733, 739, 743, 751, 757, 761, 769, 773, 787, 797, 809, 811, 821, 823, 827, 829, 839, 853,
                                 857, 859, 863, 877, 881, 883, 887, 907, 911, 919, 929, 937, 941, 947, 953, 967, 971, 977, 983, 991, 997};
    uint64_t actual[MAX_ARRAY_SIZE];
    const size_t size = sieve(actual, 1000);
    TEST_ASSERT_EQUAL_UINT(ARRAY_SIZE(expected), size);
    TEST_ASSERT_EQUAL_UINT64_ARRAY(expected, actual, size);
}

int main(void) {
    UNITY_BEGIN();
    RUN_TEST(test_no_primes_under_two);
    RUN_TEST(test_find_first_prime);
    RUN_TEST(test_find_primes_up_to_10);
    RUN_TEST(test_limit_is_prime);
    RUN_TEST(test_find_primes_up_to_1000);
    return UNITY_END();
}
