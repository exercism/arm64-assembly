FUNC_PROTO = """\
#include "vendor/unity.h"

#include <stddef.h>
#include <stdint.h>

#define MAX_ARRAY_SIZE 100
#define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))

extern size_t factors(uint64_t *dest, uint64_t value);
"""

def extra_cases():
    return [
        {
            "description": "product of three large primes",
            "property": "factors",
            "input": {
                "value": 9164464719174396253
            },
            "expected": [2077681, 2099191, 2101243]
        },
        {
            "description": "one very large prime",
            "property": "factors",
            "input": {
                "value": 4016465016163
            },
            "expected": [4016465016163]
        }
    ]

def array_literal(numbers):
    return str(numbers).replace('[', '{').replace(']', '}')

def gen_func_body(prop, inp, expected):
    value = inp["value"]
    str_list = []
    if len(expected) > 0:
        str_list.append(f'const uint64_t expected[] = {array_literal(expected)};\n')
    str_list.append(f'uint64_t actual[MAX_ARRAY_SIZE];\n')
    str_list.append(f'const size_t size = factors(actual, {value});\n')
    if len(expected) > 0:
        str_list.append(f'TEST_ASSERT_EQUAL_UINT(ARRAY_SIZE(expected), size);\n')
        str_list.append(f'TEST_ASSERT_EQUAL_UINT64_ARRAY(expected, actual, size);\n')
    else:
        str_list.append(f'TEST_ASSERT_EQUAL_UINT(0U, size);\n')
    return "".join(str_list)
