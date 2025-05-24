FUNC_PROTO = """\
#include "vendor/unity.h"

#include <stdint.h>

extern int egg_count(uint64_t number);
"""


def extra_cases():
    return [
        {
            "description": "25 eggs",
            "property": "eggCount",
            "input": {"number": 6005004003002001},
            "expected": 25,
        }
    ]


def gen_func_body(prop, inp, expected):
    number = inp["number"]
    return f"TEST_ASSERT_EQUAL_INT({expected}, egg_count({number}));\n"
