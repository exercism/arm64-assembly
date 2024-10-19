import re

FUNC_PROTO = """\
#include "vendor/unity.h"

#include <stdint.h>

extern uint64_t square(int64_t number);
extern uint64_t total(void);
"""

def gen_func_body(prop, inp, expected):
    if prop == "total":
        return f"TEST_ASSERT_EQUAL_UINT64({expected}U, {prop}());\n"

    number = inp["square"]
    if expected.__class__ == dict:
        expected = 0
    return f"TEST_ASSERT_EQUAL_UINT64({expected}U, {prop}({number}));\n"
