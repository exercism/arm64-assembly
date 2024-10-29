FUNC_PROTO = """\
#include "vendor/unity.h"

extern int valid(const char *value);
"""

def gen_func_body(prop, inp, expected):
    value = inp["value"]
    if expected:
        macro = "TEST_ASSERT_TRUE"
    else:
        macro = "TEST_ASSERT_FALSE"
    return f"{macro}(valid(\"{value}\"));\n"
