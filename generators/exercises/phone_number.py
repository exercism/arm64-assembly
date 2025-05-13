FUNC_PROTO = """\
#include "vendor/unity.h"

extern void clean(char *str);
"""


def gen_func_body(prop, inp, expected):
    str = inp["phrase"]
    if isinstance(expected, dict):
        expected = ""

    str_list = []
    str_list.append(f'char str[] = "{str}";\n')
    str_list.append("clean(str);\n")
    str_list.append(f'TEST_ASSERT_EQUAL_STRING("{expected}", str);\n')
    return "".join(str_list)
