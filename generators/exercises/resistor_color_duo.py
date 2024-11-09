FUNC_PROTO = """\
#include "vendor/unity.h"

#include <stddef.h>

extern int value(const char *first, const char *second, const char *third);
"""

def gen_func_body(prop, inp, expected):
    colors = inp["colors"]
    if len(colors) == 2:
        return f'TEST_ASSERT_EQUAL_INT({expected}, {prop}("{colors[0]}", "{colors[1]}", NULL));\n'
    else:
        return f'TEST_ASSERT_EQUAL_INT({expected}, {prop}("{colors[0]}", "{colors[1]}", "{colors[2]}"));\n'
