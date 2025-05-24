#include "vendor/unity.h"

#include <stddef.h>
#include <stdbool.h>

extern bool shared_birthday(const char **birthdates);

// estimated probability of shared birthday
extern double estimate(int group_size);

void setUp(void) {
}

void tearDown(void) {
}

void test_one_birthdate(void) {
    const char *birthdates[] = {"2000-01-01", NULL};
    TEST_ASSERT_FALSE(shared_birthday(birthdates));
}

void test_two_birthdates_with_same_year_month_and_day(void) {
    TEST_IGNORE();
    const char *birthdates[] = {"2000-01-01", "2000-01-01", NULL};
    TEST_ASSERT_TRUE(shared_birthday(birthdates));
}

void test_two_birthdates_with_same_year_and_month_but_different_day(void) {
    TEST_IGNORE();
    const char *birthdates[] = {"2012-05-09", "2012-05-17", NULL};
    TEST_ASSERT_FALSE(shared_birthday(birthdates));
}

void test_two_birthdates_with_same_month_and_day_but_different_year(void) {
    TEST_IGNORE();
    const char *birthdates[] = {"1999-10-23", "1988-10-23", NULL};
    TEST_ASSERT_TRUE(shared_birthday(birthdates));
}

void test_two_birthdates_with_same_year_but_different_month_and_day(void) {
    TEST_IGNORE();
    const char *birthdates[] = {"2007-12-19", "2007-04-27", NULL};
    TEST_ASSERT_FALSE(shared_birthday(birthdates));
}

void test_two_birthdates_with_different_year_month_and_day(void) {
    TEST_IGNORE();
    const char *birthdates[] = {"1997-08-04", "1963-11-23", NULL};
    TEST_ASSERT_FALSE(shared_birthday(birthdates));
}

void test_multiple_birthdates_without_shared_birthday(void) {
    TEST_IGNORE();
    const char *birthdates[] = {"1966-07-29", "1977-02-12", "2001-12-25", "1980-11-10", NULL};
    TEST_ASSERT_FALSE(shared_birthday(birthdates));
}

void test_multiple_birthdates_with_one_shared_birthday(void) {
    TEST_IGNORE();
    const char *birthdates[] = {"1966-07-29", "1977-02-12", "2001-07-29", "1980-11-10", NULL};
    TEST_ASSERT_TRUE(shared_birthday(birthdates));
}

void test_multiple_birthdates_with_more_than_one_shared_birthday(void) {
    TEST_IGNORE();
    const char *birthdates[] = {"1966-07-29", "1977-02-12", "2001-12-25", "1980-07-29", "2019-02-12", NULL};
    TEST_ASSERT_TRUE(shared_birthday(birthdates));
}

void test_for_one_person(void) {
    TEST_IGNORE();
    TEST_ASSERT_FLOAT_WITHIN(0.05, 0.0, estimate(1));
}

void test_among_ten_people(void) {
    TEST_IGNORE();
    TEST_ASSERT_FLOAT_WITHIN(0.05, 11.694818, estimate(10));
}

void test_among_twentythree_people(void) {
    TEST_IGNORE();
    TEST_ASSERT_FLOAT_WITHIN(0.05, 50.729723, estimate(23));
}

void test_among_seventy_people(void) {
    TEST_IGNORE();
    TEST_ASSERT_FLOAT_WITHIN(0.05, 99.915958, estimate(70));
}

int main(void) {
    UNITY_BEGIN();
    RUN_TEST(test_one_birthdate);
    RUN_TEST(test_two_birthdates_with_same_year_month_and_day);
    RUN_TEST(test_two_birthdates_with_same_year_and_month_but_different_day);
    RUN_TEST(test_two_birthdates_with_same_month_and_day_but_different_year);
    RUN_TEST(test_two_birthdates_with_same_year_but_different_month_and_day);
    RUN_TEST(test_two_birthdates_with_different_year_month_and_day);
    RUN_TEST(test_multiple_birthdates_without_shared_birthday);
    RUN_TEST(test_multiple_birthdates_with_one_shared_birthday);
    RUN_TEST(test_multiple_birthdates_with_more_than_one_shared_birthday);
    RUN_TEST(test_for_one_person);
    RUN_TEST(test_among_ten_people);
    RUN_TEST(test_among_twentythree_people);
    RUN_TEST(test_among_seventy_people);
    return UNITY_END();
}
