FUNC_PROTO = """\
#include "vendor/unity.h"

extern int leap_year(int year);
"""

def gen_func_body(prop, inp, expected):
    year = inp["year"]
    if expected:
        macro = "TEST_ASSERT_TRUE"
    else:
        macro = "TEST_ASSERT_FALSE"
    return f"{macro}({prop}({year}));\n"
