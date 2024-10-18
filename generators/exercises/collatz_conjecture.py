FUNC_PROTO = """\
#include "vendor/unity.h"

#include <stdint.h>

#define ERROR_VALUE -1

extern int steps(int64_t number);
"""

def extra_cases():
    return [
        {
            "description": "large positive",
            "property": "steps",
            "input": {
                "number": 2037066081
            },
            "expected": 817
        },
        {
            "description": "large negative",
            "property": "steps",
            "input": {
                "number": -7001002003
            },
            "expected": {
                "error": "Only positive integers are allowed"
            }
        }
    ]

def gen_func_body(prop, inp, expected):
    number = inp["number"]
    if expected.__class__ == dict:
        expected = -1
    return f"TEST_ASSERT_EQUAL_INT({expected}, {prop}({number}));\n"
