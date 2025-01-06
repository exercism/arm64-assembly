FUNC_PROTO = """\
#include "vendor/unity.h"

extern int score(double x, double y);
"""

def gen_func_body(prop, inp, expected):
    x = inp["x"]
    y = inp["y"]
    return f'TEST_ASSERT_EQUAL_INT({expected}, score({x}, {y}));\n'
