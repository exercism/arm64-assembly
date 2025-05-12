#include "vendor/unity.h"

#define BUFFER_SIZE 80

extern void encode(char *buffer, const char *msg, int rails);
extern void decode(char *buffer, const char *msg, int rails);

void setUp(void) {
}

void tearDown(void) {
}

void test_encode_with_two_rails(void) {
    char buffer[BUFFER_SIZE];

    encode(buffer, "XOXOXOXOXOXOXOXOXO", 2);
    TEST_ASSERT_EQUAL_STRING("XXXXXXXXXOOOOOOOOO", buffer);
}

void test_encode_with_three_rails(void) {
    TEST_IGNORE();
    char buffer[BUFFER_SIZE];

    encode(buffer, "WEAREDISCOVEREDFLEEATONCE", 3);
    TEST_ASSERT_EQUAL_STRING("WECRLTEERDSOEEFEAOCAIVDEN", buffer);
}

void test_encode_with_ending_in_the_middle(void) {
    TEST_IGNORE();
    char buffer[BUFFER_SIZE];

    encode(buffer, "EXERCISES", 4);
    TEST_ASSERT_EQUAL_STRING("ESXIEECSR", buffer);
}

void test_decode_with_three_rails(void) {
    TEST_IGNORE();
    char buffer[BUFFER_SIZE];

    decode(buffer, "TEITELHDVLSNHDTISEIIEA", 3);
    TEST_ASSERT_EQUAL_STRING("THEDEVILISINTHEDETAILS", buffer);
}

void test_decode_with_five_rails(void) {
    TEST_IGNORE();
    char buffer[BUFFER_SIZE];

    decode(buffer, "EIEXMSMESAORIWSCE", 5);
    TEST_ASSERT_EQUAL_STRING("EXERCISMISAWESOME", buffer);
}

void test_decode_with_six_rails(void) {
    TEST_IGNORE();
    char buffer[BUFFER_SIZE];

    decode(buffer, "133714114238148966225439541018335470986172518171757571896261", 6);
    TEST_ASSERT_EQUAL_STRING("112358132134558914423337761098715972584418167651094617711286", buffer);
}

void test_decode_with_seven_rails(void) {
    TEST_IGNORE();
    char buffer[BUFFER_SIZE];

    decode(buffer, "AGGWRHNAEROTOESTRADWETHCTTRENAAVOTHEAOECTRESIRMKEINNNEWOOENESANO", 7);
    TEST_ASSERT_EQUAL_STRING("ANANCIENTADAGEWARNSNEVERGOTOSEAWITHTWOCHRONOMETERSTAKEONEORTHREE", buffer);
}

int main(void) {
    UNITY_BEGIN();
    RUN_TEST(test_encode_with_two_rails);
    RUN_TEST(test_encode_with_three_rails);
    RUN_TEST(test_encode_with_ending_in_the_middle);
    RUN_TEST(test_decode_with_three_rails);
    RUN_TEST(test_decode_with_five_rails);
    RUN_TEST(test_decode_with_six_rails);
    RUN_TEST(test_decode_with_seven_rails);
    return UNITY_END();
}
