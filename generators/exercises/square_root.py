FUNC_PROTO = """\
#include "vendor/unity.h"

#include <stdint.h>

extern uint64_t square_root(uint64_t radicand);
"""

def extra_cases():
    return [
        {
            "description": "root of 4905601600",
            "property": "squareRoot",
            "input": {
                "radicand": 4905601600
            },
            "expected": 70040
        }
    ]

def gen_func_body(prop, inp, expected):
    radicand = inp["radicand"]
    return f"TEST_ASSERT_EQUAL_INT({expected}, square_root({radicand}));\n"
