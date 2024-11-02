FUNC_PROTO = """\
#include "vendor/unity.h"

extern int is_armstrong_number(unsigned number);
"""

def gen_func_body(prop, inp, expected):
    number = inp["number"]
    if expected:
        macro = "TEST_ASSERT_TRUE"
    else:
        macro = "TEST_ASSERT_FALSE"
    return f"{macro}({prop}({number}));\n"
