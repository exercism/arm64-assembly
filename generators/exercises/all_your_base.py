FUNC_PROTO = """\
#include "vendor/unity.h"

#include <stdint.h>

#define BUFFER_SIZE 100
#define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
#define BAD_BASE -1
#define BAD_DIGIT -2

extern int rebase(int32_t in_base, const int32_t *in_digits, int in_digit_count, int32_t out_base, int32_t *out_digits);
"""

def array_literal(digits):
    return str(digits).replace('[', '{').replace(']', '}')

def gen_func_body(prop, inp, expected):
    in_base = inp["inputBase"]
    in_digits = inp["digits"]
    out_base = inp["outputBase"]

    str_list = []
    if len(in_digits) == 0:
        str_list.append(f'const int32_t *in_digits = NULL;\n')
        in_digit_count = 0
    else:
        in_digits = array_literal(in_digits)
        str_list.append(f'int32_t in_digits[] = {in_digits};\n')
        in_digit_count = 'ARRAY_SIZE(in_digits)'
    str_list.append(f'int32_t out_digits[BUFFER_SIZE];\n')
    call = f'rebase({in_base}, in_digits, {in_digit_count}, {out_base}, out_digits)'

    if expected.__class__ == dict:
        if 'digits' in expected['error']:
            expected = 'BAD_DIGIT'
        else:
            expected = 'BAD_BASE'
        str_list.append(f'\n')
        str_list.append(f'TEST_ASSERT_EQUAL_INT({expected}, {call});\n')
    else:
        expected = array_literal(expected)
        str_list.append(f'int32_t expected[] = {expected};\n\n')
        str_list.append(f'TEST_ASSERT_EQUAL_INT(ARRAY_SIZE(expected), {call});\n')
        str_list.append(f'TEST_ASSERT_EQUAL_INT_ARRAY(expected, out_digits, ARRAY_SIZE(expected));\n')
    return "".join(str_list)
