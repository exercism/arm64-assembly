FUNC_PROTO = """\
#include "vendor/unity.h"

#include <stdint.h>

extern uint64_t prime(uint64_t number);
"""

def extra_cases():
    return [
        {
            "description": "seventh prime",
            "property": "prime",
            "input": {
                "number": 7
            },
            "expected": 17
        },
        {
            "description": "very big prime",
            "property": "prime",
            "input": {
                "number": 65537
            },
            "expected": 821647
        }
    ]

def gen_func_body(prop, inp, expected):
    number = inp["number"]
    return f'TEST_ASSERT_EQUAL_UINT({expected}, {prop}({number}));\n'
