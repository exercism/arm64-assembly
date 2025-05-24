FUNC_PROTO = """\
#include "vendor/unity.h"

extern char drinks_water(void);
extern char owns_zebra(void);
"""


def gen_func_body(prop, inp, expected):
    return f"TEST_ASSERT_EQUAL_INT('{expected[0]}', {prop}());\n"
