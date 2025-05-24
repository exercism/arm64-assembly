import re

FUNC_PROTO = """\
#include "vendor/unity.h"

#include <stdint.h>

extern uint64_t square_of_sum(uint64_t number);
extern uint64_t sum_of_squares(uint64_t number);
extern uint64_t difference_of_squares(uint64_t number);
"""


def extra_cases():
    return [
        {
            "description": "square of sum 90000",
            "property": "squareOfSum",
            "input": {"number": 90000},
            "expected": 16402864502025000000,
        },
        {
            "description": "sum of squares 90000",
            "property": "sumOfSquares",
            "input": {"number": 90000},
            "expected": 243004050015000,
        },
        {
            "description": "difference of squares 90000",
            "property": "differenceOfSquares",
            "input": {"number": 90000},
            "expected": 16402621497974985000,
        },
    ]


def to_snake_case(camel_case):
    return re.sub("([A-Z]+)", r"_\1", camel_case).lower()


def gen_func_body(prop, inp, expected):
    number = inp["number"]
    prop = to_snake_case(prop)
    return f"TEST_ASSERT_EQUAL_UINT64({expected}U, {prop}({number}));\n"
