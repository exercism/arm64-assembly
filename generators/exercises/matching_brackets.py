FUNC_PROTO = """\
#include "vendor/unity.h"

extern int is_paired(const char *value);
"""


def gen_func_body(prop, inp, expected):
    value = inp["value"].replace("\\", "\\\\")
    if expected:
        macro = "TEST_ASSERT_TRUE"
    else:
        macro = "TEST_ASSERT_FALSE"
    return f'{macro}(is_paired("{value}"));\n'
