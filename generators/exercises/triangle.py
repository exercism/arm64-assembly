FUNC_PROTO = """\
#include "vendor/unity.h"

extern int equilateral(int a, int b, int c);
extern int isosceles(int a, int b, int c);
extern int scalene(int a, int b, int c);
"""


def describe(case):
    description = case["description"]
    property = case["property"]
    return f"{property} {description}"


def gen_func_body(prop, inp, expected):
    a = inp["sides"][0]
    b = inp["sides"][1]
    c = inp["sides"][2]
    if expected:
        macro = "TEST_ASSERT_TRUE"
    else:
        macro = "TEST_ASSERT_FALSE"
    return f"{macro}({prop}({a}, {b}, {c}));\n"
