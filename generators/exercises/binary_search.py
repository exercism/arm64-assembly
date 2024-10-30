FUNC_PROTO = """\
#include "vendor/unity.h"

#include <stddef.h>
#include <stdint.h>

#define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))

extern ptrdiff_t find(int16_t value, int16_t *array, size_t count);
"""

def extra_cases():
    return [
        {
            "description": "five digits",
            "property": "steps",

            "property": "find",
            "input": {
                "array": [11638, 18389, 21454, 29416, 32039],
                "value": 21454
            },
            "expected": 2
        }
    ]

def gen_func_body(prop, inp, expected):
    value = inp["value"]
    array = inp["array"]
    if expected.__class__ == dict:
        expected = -1

    if len(array) == 0:
        return f'TEST_ASSERT_EQUAL_INT({expected}, find({value}, NULL, 0));\n'

    str_list = []
    str_list.append('int16_t array[] = {' + ', '.join(map(str, array)) + '};\n')
    str_list.append(f'TEST_ASSERT_EQUAL_INT({expected}, find({value}, array, ARRAY_SIZE(array)));\n')
    return "".join(str_list)
